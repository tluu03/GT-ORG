;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Tony Luu
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String octalString = "2110";
;;  int length = 4;
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 3;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      int digit = octalString[i] - 48;
;;      value += digit;
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    ;; YOUR CODE HERE
    AND R0, R0, 0 ;;value
    AND R1, R1, 0 ;;i
WH1 LD R2, LENGTH ;;length and also start of outer while
    NOT R2, R2 ;;start of two's complement
    ADD R2, R2, 1
    ADD R2, R2, R1 ;; add to i

    BRzp ENDWH1
    ;;WH1 body
    AND R3, R3, 0
    ADD R3, R3, 3 ;;leftshifts = 3

WH2
    ADD R4, R3, 0 ;;comparison
    BRnz ENDWH2
    ADD R0, R0, R0 ;;value += value
    ADD R3, R3, -1
    BR WH2
ENDWH2
    LD R5, OCTALSTRING ;;octal string
    ADD R5, R5, R1
    LD R7, ASCII
    LDR R6, R5, #0
    ADD R6, R6, R7

    AND R3, R3, 0
    ADD R3, R3, R6 ;;int digit = octalString - 48
    ADD R0, R0, R3 ;;value += digit
    ADD R1, R1, 1 ;;i++
    BR WH1
ENDWH1
    STI R0, RESULTADDR
    HALT
    
;; Do not change these values! 
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2110"            ;;  You can change this string for debugging!
.end
