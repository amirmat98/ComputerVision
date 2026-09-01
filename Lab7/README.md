# Lab 7: Motion Analysis and Tracking

## Overview

Lab 7 focuses on motion analysis techniques, specifically:
- **Change Detection Algorithms** using a Running Average.
- **Optical Flow Estimation** using the Lucas-Kanade method.
- **Comparison of Motion Algorithms** to evaluate their effectiveness.

---

## 🚀 Getting Started

### Prerequisites

- **MATLAB** (tested with MATLAB R2020a or later)
- Basic understanding of computer vision concepts.

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/amirmat98/ComputerVision.git
   cd ComputerVision/Lab7
   ```
2. Open MATLAB and set the working directory to `Lab7/`.
3. Download the necessary video files (already included in the `videos/` folder).
4. Run `main.m`, which calls the three exercises in turn with the parameters
   used for the report:
   ```matlab
   compareCDAlgo('videos/luce_vp.mp4', 30, 0.1, 50);
   compareCDOF('videos/tennis.mp4', 30, 0.2, 30, 8);
   segmentAndTrack('videos/DibrisHall.mp4', 50, 0.25, 10);
   ```

---

## 🔧 Implementation Details

### 1. **Change Detection Algorithms**

- `compareCDAlgo.m`: Compares the output of change detection using:
  1. A fixed background (the first frame), thresholded at `tau1`.
  2. A Running Average model for background subtraction,
     `B ← α·I + (1−α)·B`, thresholded at `tau2`.

  The original video, both background models and both binary maps are shown
  side by side, frame by frame.

### 2. **Optical Flow Estimation**

- `opticalFlowLK.m`: Lucas-Kanade optical flow, implemented from scratch.
  Spatial and temporal gradients are computed with `conv2`, and for every pixel
  the over-determined system built from a `W × W` window is solved in the least
  squares sense (`pinv(AᵀA)Aᵀb`), giving the flow components `u` and `v`.
- `compareCDOF.m`: Compares the output of change detection (Running Average)
  and Optical Flow using the Lucas-Kanade method, displaying the frame, the
  colour-coded flow, the binary map and the running-average background together.

### 3. **Flow Visualization**

- `convertToMagDir.m`: Converts the two flow components into a colour image.
  Direction (`atan2(v, u)`) is mapped to hue and normalized magnitude to value,
  and the HSV image is converted to RGB — so colour encodes the direction of
  motion and brightness encodes its speed.

### 4. **Tracker Implementation**

- `segmentAndTrack.m`: Segments and tracks a manually selected target.
  The background is updated with a selective running average — only pixels whose
  difference from the background is below `tau2` are updated, so the moving
  target does not bleed into the model — and change detection thresholds at
  `tau1`. At a fixed frame index the user clicks the target with `ginput`; from
  then on each frame's binary map is decomposed with `bwconncomp`, small blobs
  are rejected by area, and the target is re-associated to the nearest centroid.
  The accumulated trajectory is drawn over the video and over the final frame.

---

## 📊 Results

- Outputs from change detection and optical flow algorithms are visualized side-by-side.
- The effectiveness of each approach is analyzed for different video sequences (`luce_vp.mp4`, `tennis.mp4`, `DibrisHall.mp4`), the last of which was recorded in the DIBRIS department building.
