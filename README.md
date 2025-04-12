# 🚇 Subway Surfers: On-Chain Escape

**Subway Surfers: On-Chain Escape** is a fully on-chain endless runner game built with Solidity.  
Dodge obstacles, score points, and push your luck — all on the blockchain.  
No graphics. No frontend. Just pure smart contract survival.

---

## 🎮 How It Works

- You start a new run with `startRun()`.
- Then, call `step(dodgeLeft, dodgeRight)` to dodge randomly generated obstacles.
- Score increases every time you dodge successfully.
- Game ends if you crash into an obstacle.

---

## 💡 Gameplay Logic

```solidity
- Randomly generated obstacle:
  - 0 = left obstacle
  - 1 = right obstacle
  - 2 = no obstacle

- If you:
  - dodgeLeft on left obstacle ✅
  - dodgeRight on right obstacle ✅
  - stay center on no obstacle ✅
  - else → Game Over ❌
