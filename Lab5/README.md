# Lab 5: NCC-based Segmentation and Harris Corner Detection

## Overview

Lab 5 compares two ways of locating an object in an image sequence, and then
implements a classical interest-point detector:

- **Template matching** with normalized cross-correlation (NCC).
- **Colour-based segmentation** in the HSV space, as a baseline to compare
  against.
- **Harris corner detection**, implemented from the structure tensor upwards.

The detection experiments run on six frames of a traffic sequence
(`ur_c_s_03a_01_L_0376.png` … `ur_c_s_03a_01_L_0381.png`), tracking a red car
that stays roughly in place and a dark car that turns left — the harder of the
two, because both its position and its apparent shape change.

---

## 🚀 Getting Started

### Prerequisites

- **MATLAB** with the Image Processing Toolbox (`normxcorr2`, `rgb2hsv`,
  `bwlabel`, `regionprops`).

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/amirmat98/ComputerVision.git
   cd ComputerVision/Lab5
   ```
2. Open MATLAB and set the working directory to `Lab5/`.
3. Run `Main.m`.

`Main.m` is a thin driver holding one call per exercise. The calls are
commented out by default so that only the part you are interested in runs —
uncomment the one you want:

```matlab
% Template_Matching()
% ColorBased_Segmentation()
Harris_Corner()
```

All three functions read their input images with relative paths, so the
working directory has to be `Lab5/`.

---

## 🔧 Implementation Details

### 1. NCC template matching — `Template_Matching.m`

Two patches are cropped from the first frame: one around the red car
(`Image1(350:430, 680:780)`) and one around the black car
(`Image1(365:415, 555:645)`). Each patch is correlated against all six
greyscale frames with `normxcorr2`. The maximum of the resulting score map
gives the detection, which is drawn as a red dot plus a rectangle the size of
the template. The score maps themselves are plotted alongside, so the shape of
the correlation peak can be inspected.

Normalization is what makes this robust: subtracting the mean and dividing by
the standard deviation of both patch and window removes the sensitivity to
absolute intensity, contrast and illumination that plain cross-correlation has.

### 2. Colour-based segmentation — `ColorBased_Segmentation.m`

Each frame is converted to HSV and segmented on the hue channel:

- **Black car** — a small region of the car is sampled from the first frame and
  its hue mean and standard deviation are computed; the mask keeps pixels with
  hue in `mean ± std`.
- **Red car** — a fixed hue window of `0.97 < H < 1` is used.

The binary mask is labelled with `bwlabel`, `regionprops` extracts area,
centroid and bounding box, and the largest-area blob is taken as the detection.
Results are drawn over both the mask and the greyscale frame.

### 3. Harris corner detection — `Harris_Corner.m`

Implemented step by step on `i235.png`:

1. Image derivatives `Ix`, `Iy` via Sobel kernels and `conv2`.
2. Products `Ix²`, `Iy²`, `IxIy`, smoothed by a 9×9 Gaussian window
   (`fspecial('gaussian', 9, 1.2)`) to form the structure tensor
   `M = [Sx² Sxy; Sxy Sy²]` at every pixel.
3. Corner response `R = det(M) − k·trace(M)²` with `k = 0.05`.
4. Thresholding at `0.3 · max(R)` to separate corner regions from flat and
   edge regions.
5. `bwlabel` + `regionprops` on the thresholded map to reduce each corner
   region to a single centroid, plotted over the original image.

Intermediate results — the partial derivatives, the Gaussian window, the R map
and the corner/non-corner masks — are all displayed.

---

## 📊 Results

The full discussion, with all figures, is in the LaTeX report:
[`Report/main.tex`](Report/main.tex) → [`Report/main.pdf`](Report/main.pdf).
The original course assignment brief is [`Lab5.pdf`](Lab5.pdf).

Summary of the conclusions drawn in the report:

- **Template matching is the more accurate of the two methods** for this
  sequence. Both cars are located with high precision; the only visible defect
  is that part of the black car's front falls outside the box in the last
  frame, after it has turned.
- **Colour-based segmentation** is cheap and easy to implement, but it depends
  entirely on colour. For the red car it recovers only the red bodywork —
  tyres and mirrors have different colour-space properties and are missed. For
  the black car it fails to capture the full outline, because the car's hue is
  close to that of the surrounding scene and its appearance changes as it
  turns.
- **Patch size** was studied with three windows around the black car: a tight
  fit, a slightly larger one, and one including a good deal of surrounding
  context. Larger patches cost more computation time and more memory, and buy
  some robustness to rotation and illumination change, but they also drag
  irrelevant background into the detected region. The tight-fitting window
  gives the most accurate maximum-score point.
