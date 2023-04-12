;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Tony Luu
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  int x = 17;
;;  int mod = 5;
;;  while (x >= mod) {
;;      x -= mod;
;;  }
;;  mem[ANSWER] = x;

.orig x3000
    ;; YOUR CODE HERE
    ;; Loading X and MOD into registers
    LD R1, X
    LD R2, MOD
    ;; negative mod section
    ;; also adds one(two's complement)
    NOT R3, R2
    ADD R3, R3, #1
    ;;While loop using branching (start)
WH  AND R4, R4, #0
    ADD R4, R1, R3
    BRn ENDWH

    ;;Actual x -= mod operation
    ADD R1, R1, R3
    ;;(end)

    BR WH
    ;;Store x into address ANSWER
ENDWH ST R1, ANSWER
    HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 17
    MOD    .fill 5     
    ANSWER .blkw 1
.end