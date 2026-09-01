# Lab 6: Fundamental Matrix Estimation

## Overview

Lab 6 is about epipolar geometry: recovering the fundamental matrix **F** that
relates a stereo pair, and validating it through the epipolar constraint
`x₂ᵀ F x₁ = 0`.

- **Part I** — estimate **F** from known correspondences with the 8-point
  algorithm, in both its plain and its normalized (Hartley) form, and compare
  the two.
- **Part II** — the harder case with no correspondences given: find matches
  automatically (NCC or SIFT), then estimate **F** robustly with RANSAC.

Two stereo pairs are provided: `Rubik/` (a Rubik's cube scene) and `Mire/` (a
calibration target), each with `.pgm` images and a `.points` file of manually
selected correspondences.

---

## 🚀 Getting Started

### Prerequisites

- **MATLAB** with the Image Processing Toolbox and the Computer Vision Toolbox
  (`detectSIFTFeatures`, `extractFeatures`).

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/amirmat98/ComputerVision.git
   cd ComputerVision/Lab6
   ```
2. Open MATLAB and set the working directory to `Lab6/`.
3. Run `main_part1.m` for Part I and `main_part2.m` for Part II.

Both scripts select the image set at the top; swap the commented line to switch
between the two pairs:

```matlab
% [img, img1, Points1, Points2] = import_files("Mire");
[img, img1, Points1, Points2] = import_files("Rubik");
```

> **Note:** `import_files.m` builds its paths with Windows backslashes
> (`'Rubik\Rubik1.pgm'`). On Linux or macOS these need to be forward slashes.

---

## 🔧 Implementation Details

### Part I — 8-point algorithm (`main_part1.m`)

#### `EightPointsAlgorithm.m` — plain 8-point

1. Build the linear system `A f = 0`, one row per correspondence, from the
   Kronecker-style products of the two homogeneous point sets.
2. Solve by SVD: the last column of `V` is the least-squares solution `f`.
3. Reshape the 9×1 solution into a 3×3 matrix.
4. Enforce `rank(F) = 2` explicitly: take `svd(F)`, set the smallest singular
   value `D(3,3)` to zero, and recompose `F = U D Vᵀ`.

#### `EightPointsAlgorithmN.m` — normalized 8-point

Normalizes both point sets with `normalise2dpts.m` (translate to the centroid,
scale so the mean distance from the origin is √2), runs the plain algorithm on
the normalized points, and denormalizes the result as `F = T₂ᵀ F̃ T₁`.
Normalizing conditions the linear system and makes the estimate markedly less
sensitive to noise.

#### Validation

- `testF.m` — evaluates `|x₂ᵀ F x₁|` at every correspondence; ideally zero.
- `visualizeEpipolarLines.m` — draws the two images side by side with the
  correspondences and their epipolar lines. Called with empty point lists it
  switches to interactive mode: click a point in either image and the matching
  epipolar line is drawn in the other.
- The **epipoles** are recovered as the last columns of `U` and `V` from
  `svd(F)` (the left and right null spaces), and `eₗᵀ F e_r` is evaluated as a
  further check.

### Part II — matching + RANSAC (`main_part2.m`)

#### `findMatches.m`

SIFT keypoints are detected in both images with `detectSIFTFeatures`, and
keypoints too close to the border are discarded. An affinity matrix is then
built with one of two similarity measures, selected by the `type` argument:

- `'NCC'` — combines the normalized cross-correlation between the patches
  around the two keypoints with a Gaussian prior on their Euclidean distance
  (`similarity.m`, patch half-size `delta`, distance weight `sigma`).
- `'SIFT'` — Euclidean distance between the 128-dimensional SIFT descriptors,
  passed through a Gaussian kernel.

In both cases the affinity matrix is enhanced by replacing its singular values
with ones (`A' = U I Vᵀ`), and a match is accepted only if it is a mutual
maximum in its row and column and exceeds a threshold. `show_matches.m`
displays the resulting correspondences across the pair.

#### `ransacF.m`

Robust estimation on top of the normalized 8-point algorithm: sample 8 random
correspondences, fit **F**, score all points with `|x₂ᵀ F x₁|` against a
threshold `th`, and keep the model with the largest consensus set. The
iteration count starts at 100 and is updated adaptively from the current inlier
ratio for a success probability of `p = 0.999`. Returns the best **F** together
with its inliers and outliers.

---

## 📊 Results

The full discussion, with all figures, is in the LaTeX report:
[`Report/main.tex`](Report/main.tex) → [`Report/main.pdf`](Report/main.pdf).
Saved output figures for the Rubik pair are in [`Rubik/`](Rubik/).

Summary of the findings reported:

**Part I — normalization matters.** On the Rubik pair (13 correspondences), the
epipolar residuals `|xᵀFx|` from the plain algorithm range from about
5×10⁻³ up to 0.85, while the normalized algorithm keeps every residual around
10⁻³. The epipolar lines confirm this visually: without normalization they miss
the correspondences noticeably, with normalization they pass through or very
close to them. The Mire pair is estimated more accurately than Rubik with both
variants. The epipolar constraint evaluated on the epipoles themselves is
satisfied to ~10⁻²² (plain) and ~10⁻²⁵ (normalized).

**Part II — an honest negative result.** On the Rubik pair, neither the NCC nor
the SIFT branch of `findMatches` produced correct correspondences for any of the
parameter settings tried (several values of `sigma` and `delta` were tested and
are left commented in the source). With `sigma = 5, delta = 4` the NCC branch
does return matches, but they are visibly wrong; the SIFT branch behaves the
same way. Because RANSAC assumes that the majority of its input are inliers, it
then optimizes against a set dominated by bad matches, and the resulting **F**
produces incorrect epipolar lines — even though the residuals measured *on its
own consensus set* are close to zero. The report analyses this failure mode and
concludes that careful filtering of the correspondences before RANSAC is
essential.
