# ComputerVision
this repository is specified for the projects of ComputerVision course of master of robotics engineering of univeristy of Genova

## Lab 7: Motion Analysis and Tracking

### Overview

Lab 7 focuses on motion analysis techniques, specifically:
- **Change Detection Algorithms** using a Running Average.
- **Optical Flow Estimation** using the Lucas-Kanade method.
- **Comparison of Motion Algorithms** to evaluate their effectiveness.

---

### 🚀 Getting Started

#### Prerequisites

- **MATLAB** (tested with MATLAB R2020a or later)
- Basic understanding of computer vision concepts.

#### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/amirmat98/ComputerVision.git
   cd ComputerVision/Lab7
   ```
2. Open MATLAB and set the working directory to `Lab7/`.
3. Download the necessary video files (already included in the `videos/` folder).

---

### 🔧 Implementation Details

#### 1. **Change Detection Algorithms**

- `compareCDAlgo.m`: Compares the output of change detection using:
  1. A fixed background (single frame or average of the first N frames).
  2. A Running Average model for background subtraction.

#### 2. **Optical Flow Estimation**

- `compareCDOF.m`: Compares the output of change detection (Running Average) and Optical Flow using the Lucas-Kanade method.

#### 3. **Motion Algorithm Comparison**

- `MotionAlgoComparison.m`: Implements a comparative analysis pipeline:
  - Estimates optical flow and visualizes its magnitude.
  - Runs change detection with a Running Average and visualizes the binary output.
  - Presents both results in a subplot for comparison.

#### 4. **Auxiliary Functions**

- `auxiliary_functions.m`: Helper functions for common operations such as:
  - Frame pre-processing.
  - Gray-level conversion.
  - Visualization utilities.

#### 5. **Optional Tracker Implementation**

- Implements a simple tracker for a manually selected target based on the provided video `DibrisHall.mp4`.

---

### 📊 Results

- Outputs from change detection and optical flow algorithms are visualized side-by-side.
- The effectiveness of each approach is analyzed for different video sequences (`luce_vp.mp4`, `tennis.mp4`, `DibrisHall.mp4`).
