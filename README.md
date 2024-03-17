# Fast Matrix Inversion in Compressive Spectral Imaging based on a Tensorial Representation [SPIE](https://www.spiedigitallibrary.org/journals/journal-of-electronic-imaging/volume-33/issue-1/013034/Fast-matrix-inversion-in-compressive-spectral-imaging-based-on-a/10.1117/1.JEI.33.1.013034.short)

## Abstract

Snapshot spectral imaging enables the acquisition of hyperspectral images (HSI) employing specialized optical systems, such as the coded aperture snapshot spectral imager (CASSI). Specifically, the CASSI system performs spatiospectral codification of light obtaining two-dimensional projected measurements, and these measurements are then processed by computational algorithms to obtain the desired spectral images. However, because HSIs often have a high spatial or spectral resolution, the sensing matrix related to the acquisition protocol becomes very large, leading to a high computational storage cost and long computation times. In this work, we propose an algebraic framework for computing the relevant operations in a tensorial form based on the nature of the codification protocol. We then test our framework against some comparison methods based on linear algebra decomposition, factorization, or block-operations, demonstrating that the proposed method is between 3 and 20 times faster than the best-competing method. Moreover, the gain becomes larger when the matrices become bigger, corresponding to realistic HSI sizes for spectral imaging applications. In extreme cases, our method can still operate when the competing methods stall due to memory shortage.

## Implementation Details

The code includes two main Live Scripts:

1. **`proposed_method.mlx`:** This script contains the implementation of the proposed framework. Use this script to explore and utilize the features of the proposed method.
2. **`speed_comparison.mlx`:** This script facilitates a speed comparison, allowing you to assess the computational efficiency of the inversion process when compared to other methods.

## Usage

Follow these steps to effectively use the provided code:

1. Open and run `proposed_method.mlx` to see the proposed framework in action.
2. Execute `speed_comparison.mlx` to compare the speed of the inversion process against other methods.

Feel free to explore, modify, and adapt the code to suit your specific needs. If you have any questions or encounter issues, please refer to the paper or reach out for assistance.

## How to cite

If the provided code is useful for your research and you will use it in your research work, please cite this paper as

```bibtex
@article{carlsson2024fast,
  title={Fast matrix inversion in compressive spectral imaging based on a tensorial representation},
  author={Carlsson, Marcus and Martinez, Emmanuel and Vargas, Edwin and Arguello, Henry},
  journal={Journal of Electronic Imaging},
  volume={33},
  number={1},
  pages={013034--013034},
  year={2024},
  publisher={Society of Photo-Optical Instrumentation Engineers}
}
```
