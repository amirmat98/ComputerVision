# Lab 2: Image Filtering and Fourier Transform

## Overview

Lab 2 covers the basics of spatial filtering and frequency-domain analysis:

- **Noise models** — hand-written Gaussian and salt & pepper noise generators.
- **Denoising filters** — moving average, low-pass Gaussian and median filters,
  each at two spatial supports (3×3 and 7×7 pixels).
- **Linear filter design** — identity, translation and sharpening kernels.
- **Fourier analysis** — 2-D FFT of the images and of the filters, visualized
  as log-magnitude spectra.

---

## 🚀 Getting Started

### Prerequisites

- **MATLAB** with the Image Processing Toolbox (`imhist`, `medfilt2`,
  `fspecial`, `imfilter`).

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/amirmat98/ComputerVision.git
   cd ComputerVision/Lab2
   ```
2. Open MATLAB and set the working directory to `Lab2/`.
3. Run `main.m`. The helper functions (`Guassian_Noise.m`, `Salt_Pepper.m`,
   `Drawing.m`) live in the same folder and are picked up automatically.

The script reads `tree.png` and `i235.png` with relative paths, so the working
directory has to be `Lab2/`. It opens a large number of figures, each titled
with the noise and filter it illustrates.

---

## 🔧 Implementation Details

### 1. Noise generation

- `Guassian_Noise.m` — adds zero-mean Gaussian noise of a given standard
  deviation to the image (`X + STD*randn(size(X))`). `main.m` uses σ = 20.
- `Salt_Pepper.m` — builds a sparse random mask with `sprand` at the requested
  density and drives the selected pixels to 0 (pepper) or to the image maximum
  (salt). `main.m` uses a density of 0.2.

Original and noisy images are displayed together with their histograms, so the
effect of each noise model on the intensity distribution is visible.

### 2. Denoising filters

| Filter | Construction | Sizes |
|--------|--------------|-------|
| Moving average | `1/9*ones(3)`, `1/49*ones(7)`, applied with `conv2` | 3×3, 7×7 |
| Low-pass Gaussian | `fspecial('gaussian', 3, 0.5)`, `fspecial('gaussian', 7, 7/6)`, applied with `imfilter` | 3×3, 7×7 |
| Median | `medfilt2` | 3×3, 7×7 |

Each kernel is shown with both `imagesc` and `surf`, and every filtered result
is plotted next to its histogram by the `Drawing.m` helper, which takes the
image, the noise name, the filter name and the filter size and labels the
figure accordingly.

### 3. Practice with linear filters

Four 7×7 kernels are built and convolved with both images:

- `F1` — a single 1 at the centre: the identity, leaves the image unchanged.
- `F2` — a single 1 off-centre: translates the image.
- `F3`, `F4` — `2·δ − 1/49·ones(7)` and `3·δ − 1/49·ones(7)`: sharpening
  kernels of increasing strength.

### 4. Fourier transform

`fft2` is applied to both images and the log-magnitude spectrum is displayed
with `fftshift`. The same is done for a 101×101 low-pass Gaussian filter
(σ = 5) and for the sharpening kernel zero-padded into a 101×101 support, so
the low-pass and high-pass characters of the two filters can be compared in the
frequency domain.

---

## 📊 Results

The full discussion, with all figures, is in the LaTeX report:
[`Report/main.tex`](Report/main.tex) → [`Report/main.pdf`](Report/main.pdf).
The original course assignment brief is [`Lab2.pdf`](Lab2.pdf), and
[`Lab2_Report.pdf`](Lab2_Report.pdf) is a top-level copy of the compiled report.

Summary of the conclusions drawn in the report:

- The **moving average** filter is simple and cheap, but blurs edges and fine
  detail; at 7×7 it still fails to remove salt & pepper noise.
- The **low-pass Gaussian** filter gives the best compromise between noise
  reduction and detail preservation on Gaussian noise, because it weights the
  central pixel more heavily than its neighbours. Like the moving average, it
  cannot remove salt & pepper noise — the saturated pixels survive the
  weighted sum regardless of kernel size.
- The **median** filter is clearly the best of the three on salt & pepper
  noise, since the extreme pixel values are rejected as outliers by the median.
  It is less effective on Gaussian noise, and large supports start to erase
  thin structures.
