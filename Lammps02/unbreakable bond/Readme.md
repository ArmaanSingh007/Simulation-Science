# CNT Stretching Simulation with LAMMPS (Unbreakable Bonds - OPLS-AA)

This project demonstrates how to perform a molecular dynamics (MD) simulation of a carbon nanotube (CNT) being stretched under constant velocity using the LAMMPS simulation package. The atomic interactions are governed by the OPLS-AA force field with unbreakable bonds.

---

## 📁 Files

| File | Description |
|------|-------------|
| `input.lammps.txt` | Main LAMMPS input script for the CNT deformation |
| `unbreakable.data` | Topology and atomic coordinates for the CNT |
| `unbreakable.inc` | Force field parameters (LJ, bond, angle, dihedral) |
| `dump.cnt.lammpstrj` | Output trajectory (generated after running the script) |

---

📽️ This project is part of a tutorial video available on YouTube:  
**https://www.youtube.com/watch?v=f_9pKfxA1gI** 

---

## 🔬 Simulation Overview

- **Simulation Type:** MD with tensile strain
- **Material:** Single-walled carbon nanotube (CNT)
- **Force Field:** OPLS-AA (harmonic bonds, angles, dihedrals)
- **Units:** real (distance in Å, time in fs)
- **Boundary Conditions:** Non-periodic (fixed)
- **Deformation Mode:** Constant velocity pulling at CNT edges
- **Temperature Control:** Nosé–Hoover thermostat on central atoms

---

## 📚 Reference

This example is based on:

> Gravelle, S., Gissinger, J.R., & Kohlmeyer, A. (2025). *A Set of Tutorials for the LAMMPS Simulation Package*. [LiveCoMS Article](https://github.com/lammpstutorials/lammpstutorials-article)

---

## ▶️ Running the Simulation

Make sure you have LAMMPS installed. Then, run the simulation with:

```bash
lmp -in input.lammps.txt

