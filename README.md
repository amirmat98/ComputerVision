# Computer Vision — Lab Portfolio

MATLAB implementations of classical computer vision algorithms, written from
scratch as self-study for the **Computer Vision** course (code 77802) of the
MSc in Robotics Engineering, DIBRIS — University of Genoa.

Each lab is a self-contained MATLAB project with its own entry-point script,
input data, and a full LaTeX report (source + compiled PDF) discussing the
method and the results.

| Lab | Topic | Key algorithms |
|-----|-------|----------------|
| [Lab2](Lab2/) | Image filtering and the Fourier transform | Gaussian & salt-and-pepper noise models, moving-average / low-pass Gaussian / median filtering, linear filter design, 2-D FFT analysis |
| [Lab5](Lab5/) | Segmentation and feature detection | Normalized cross-correlation template matching, HSV colour-based segmentation, Harris corner detector |
| [Lab6](Lab6/) | Epipolar geometry | 8-point algorithm, normalized (Hartley) 8-point algorithm, RANSAC fundamental-matrix estimation, SIFT/NCC feature matching, epipolar line and epipole visualization |
| [Lab7](Lab7/) | Motion analysis and tracking | Lucas–Kanade optical flow, static vs. running-average background modelling, change detection, blob-association tracker |

## Tech stack

- **MATLAB** throughout (no other language in the repository).
- Toolboxes used: Image Processing Toolbox (`imhist`, `medfilt2`, `fspecial`,
  `normxcorr2`, `bwlabel`, `regionprops`, `rgb2hsv`, …) and Computer Vision
  Toolbox (`detectSIFTFeatures`, `extractFeatures`, `VideoReader`).
  Lab 6 therefore needs a MATLAB release in which `detectSIFTFeatures` is
  available.
- Reports are LaTeX (`article` class, `biblatex`/`biber`); each `Report/`
  directory contains the sources plus the compiled `main.pdf`.

## Repository layout

```
Lab2/    Image filtering and Fourier transform
Lab5/    NCC-based segmentation and Harris corner detection
Lab6/    Fundamental matrix estimation
Lab7/    Motion analysis and tracking
```

Every lab directory holds its MATLAB sources, the input images or videos it
needs, a `Report/` folder with the LaTeX write-up, and a `README.md`
describing what is implemented and how to run it.

## Running a lab

```bash
git clone https://github.com/amirmat98/ComputerVision.git
cd ComputerVision/Lab2      # or Lab5, Lab6, Lab7
```

Open MATLAB, set the working directory to that lab folder (the scripts read
their input files with relative paths), and run the lab's entry-point script:

| Lab | Entry point |
|-----|-------------|
| Lab2 | `main.m` |
| Lab5 | `Main.m` |
| Lab6 | `main_part1.m`, `main_part2.m` |
| Lab7 | `main.m` |

## Author

AmirMahdi Matin — MSc Robotics Engineering, University of Genoa.
Course held by Prof. Nicoletta Noceti and Prof. Fabio Solari.

## License

[MIT](LICENSE)
