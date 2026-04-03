# hypothetical.R
# Hypothetical results figure for yellow toadflax biocontrol experiment.
# Treatments: Control, M. janthinus (stem borer), R. pilosa (galler), Both
# Time points: Weeks 1, 2, 4, 7
# Response variables:
#   - Net photosynthesis (Aₙ) from LI-6400
#   - Water Band Index (WBI = R900/R970) from ASD spectroradiometer

library(tidyverse)
library(patchwork)

set.seed(5821)

# ── Treatment metadata ────────────────────────────────────────────────────────

weeks      <- c(1, 2, 4, 7)
treatments <- c("Control", "M. janthinus", "R. pilosa", "Both")

# Color and shape scales shared across both panels
trt_colors <- c("Control"      = "#4D9DE0",
                "M. janthinus" = "#E15554",
                "R. pilosa"    = "#3BB273",
                "Both"         = "#7768AE")

trt_shapes <- c("Control" = 16, "M. janthinus" = 17,
                "R. pilosa" = 15, "Both" = 18)

# Legend labels with italicized species names and functional role
trt_labels <- c("Control",
                expression(italic("M. janthinus")*" (stem-miner)"),
                expression(italic("R. pilosa")*" (galler)"),
                "Both")

# ── Hypothetical data ─────────────────────────────────────────────────────────
# Design logic:
#   - Weeks 1-2: no divergence (insects present but undeveloped)
#   - Week 4: treatments begin to diverge
#   - Week 7: clear separation; M. janthinus (stem borer) > R. pilosa (galler)
#             in effect size; combined treatment strongest
# Values represent group means ± 1 SE (n = 8 per group)

# Net photosynthesis (µmol CO2 m⁻² s⁻¹)
photo_means <- tibble(
  week      = rep(weeks, each = 4),
  treatment = factor(rep(treatments, 4), levels = treatments),
  mean      = c(
    15.1, 15.0, 14.9, 15.0,   # wk1 - no difference
    15.2, 14.8, 15.1, 14.7,   # wk2 - minimal divergence
    15.0, 12.3, 13.4, 10.8,   # wk4 - starting to diverge
    14.9,  7.8,  9.9,  5.9    # wk7 - clear separation
  ),
  se        = c(
    0.5, 0.5, 0.5, 0.5,
    0.5, 0.6, 0.5, 0.7,
    0.5, 0.9, 0.8, 1.1,
    0.6, 1.1, 0.9, 1.3
  )
)

# Water Band Index (WBI = R900/R970)
# Higher WBI = less water stress; healthy plants ~1.09-1.11
wbi_means <- tibble(
  week      = rep(weeks, each = 4),
  treatment = factor(rep(treatments, 4), levels = treatments),
  mean      = c(
    1.098, 1.097, 1.099, 1.096,   # wk1 - flat
    1.100, 1.094, 1.098, 1.092,   # wk2 - minimal
    1.089, 1.061, 1.074, 1.043,   # wk4 - diverging
    1.062, 0.998, 1.029, 0.961    # wk7 - clear separation
  ),
  se        = c(
    0.004, 0.004, 0.004, 0.005,
    0.004, 0.005, 0.004, 0.006,
    0.004, 0.008, 0.007, 0.010,
    0.008, 0.011, 0.009, 0.013
  )
)

# ── Simple two-treatment figure: Control vs. Infested (WBI) ──────────────────
# Collapsed version of the full experiment — all infestation treatments pooled
# into a single "Infested" group. Same lag structure: weeks 1-2 flat,
# divergence begins week 4, clear separation by week 7.
# SE values are larger here to reflect pooled within-group variability.
# Values represent group means ± 1 SE (n = 8 per group)

wbi_simple <- tibble(
  week      = rep(weeks, each = 2),
  treatment = factor(rep(c("Control", "Infested"), 4),
                     levels = c("Control", "Infested")),
  mean      = c(
    1.098, 1.097,   # wk1 - flat
    1.097, 1.093,   # wk2 - minimal divergence
    1.083, 1.058,   # wk4 - starting to diverge
    1.069, 0.981    # wk7 - clear separation
  ),
  se        = c(
    0.012, 0.015,
    0.012, 0.018,
    0.012, 0.027,
    0.015, 0.036
  )
)

ggplot(wbi_simple, aes(x = week, y = mean, color = treatment,
                       shape = treatment, fill = treatment)) +
  geom_ribbon(aes(ymin = mean - se, ymax = mean + se),
              alpha = 0.14, color = NA) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 3.2) +
  scale_x_continuous(breaks = weeks) +
  scale_color_manual(values = c("Control" = "#4D9DE0", "Infested" = "#E15554")) +
  scale_fill_manual(values  = c("Control" = "#4D9DE0", "Infested" = "#E15554")) +
  scale_shape_manual(values = c("Control" = 16, "Infested" = 17)) +
  labs(x = "Week", y = "Water Band Index (WBI = R900/R970)",
       color = NULL, fill = NULL, shape = NULL) +
  theme_bw(base_size = 14) +
  theme(
    panel.grid      = element_blank(),
    panel.border    = element_blank(),
    axis.line       = element_line(color = "black"),
    legend.position = "bottom",
    legend.text     = element_text(size = 12),
    axis.title      = element_text(face = "plain")
  )


# ── Shared plot theme (presentation style) ────────────────────────────────────

pres_theme <- theme_bw(base_size = 14) +
  theme(
    panel.grid        = element_blank(),        # remove all gridlines
    panel.border      = element_blank(),        # remove full plot border
    axis.line         = element_line(color = "black"),  # keep only bottom and left axes
    legend.text.align = 0,
    legend.key.height = unit(1.2, "lines"),
    axis.title        = element_text(face = "plain")
  )

# ── Panel 1: Net photosynthesis ───────────────────────────────────────────────

p1 <- ggplot(photo_means,
             aes(x = week, y = mean, color = treatment,
                 shape = treatment, fill = treatment)) +
  geom_ribbon(aes(ymin = mean - se, ymax = mean + se),
              alpha = 0.14, color = NA) +       # shaded ±1 SE band
  geom_line(linewidth = 1.1) +
  geom_point(size = 3.2) +
  scale_x_continuous(breaks = weeks) +
  scale_color_manual(values = trt_colors, labels = trt_labels) +
  scale_fill_manual(values  = trt_colors, labels = trt_labels) +
  scale_shape_manual(values = trt_shapes, labels = trt_labels) +
  labs(
    x = "Week",
    y = expression(italic(A)[n]~"(µmol CO"[2]~"m"^{-2}~"s"^{-1}*")"),
    color = NULL, fill = NULL, shape = NULL
  ) +
  pres_theme

# ── Panel 2: Water Band Index ─────────────────────────────────────────────────

p2 <- ggplot(wbi_means,
             aes(x = week, y = mean, color = treatment,
                 shape = treatment, fill = treatment)) +
  geom_ribbon(aes(ymin = mean - se, ymax = mean + se),
              alpha = 0.14, color = NA) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 3.2) +
  scale_x_continuous(breaks = weeks) +
  scale_color_manual(values = trt_colors, labels = trt_labels) +
  scale_fill_manual(values  = trt_colors, labels = trt_labels) +
  scale_shape_manual(values = trt_shapes, labels = trt_labels) +
  labs(
    x = "Week",
    y = "Water Band Index (WBI = R900/R970)",
    color = NULL, fill = NULL, shape = NULL
  ) +
  pres_theme

# ── Combine panels with patchwork ─────────────────────────────────────────────

print(
  (p1 + p2) +
    plot_layout(guides = "collect") &
    theme(
      legend.position = "bottom",
      legend.text     = element_text(size = 12)
    )
)
