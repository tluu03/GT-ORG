
;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Factorial
;;=============================================================
;;  Name: Tony Luu
;;============================================================

;;  In this file, you must implement the 'MULTIPLY' and 'FACTORIAL' subroutines.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'MULTIPLY' or 'FACTORIAL' labels
;;      * Add the [a, b] or [n] params separated by a comma (,) 
;;        (e.g. 3, 5 for 'MULTIPLY' or 6 for 'FACTORIAL')
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. 3 * 5 = 15 or 6! = 720)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here

;;  MULTIPLY Pseudocode (see PDF for explanation and examples)   
;;  
;;  MULTIPLY(int a, int b) {
;;      int ret = 0;
;;      while (b > 0) {
;;          ret += a;
;;          b--;
;;      }
;;      return ret;
;;  }

MULTIPLY ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the MULTIPLY subroutine here!
    ADD R6, R6, #-4 ;;ret value
    STR R7, R6, #2 ;;ret address
    STR R5, R6, #1 ;;old fp(frame pointer)
    ADD R5, R6, #0 ;;copies stack pointer to frame pointer
    ADD R6, R6, #-5 ;;make room for 5 registers

    STR R0, R5, #0
    STR R1, R5, #1
    STR R2, R5, #2
    STR R3, R5, #3
    STR R4, R5, #4
    ;;EVERYTHING ABOVE is part of the calling behavior, the work below is the mult implementation
    ;;Stack buildup
    ;;Subroutine below
    AND R3, R3, #0 ;;ret = 0 create ret value
    LDR R0, R5, #4 ;;ret a
    LDR R1, R5, #5 ;;ret b
WH1
    BRnz ENDWH1
    ADD R3, R3, R0 ;;ret += a
    ADD R1, R1, #-1 ;;decremet b
    BR WH1
ENDWH1 
    STR R3, R5, #3 ;;sets ret to answer
    ;;Stack breakdown
    LDR R4, R5, #-5
    LDR R3, R5, #-4
    LDR R2, R5, #-3
    LDR R1, R5, #-2
    LDR R0, R5, #-1
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
    RET

;;  FACTORIAL Pseudocode (see PDF for explanation and examples)
;;
;;  FACTORIAL(int n) {
;;      int ret = 1;
;;      for (int x = 2; x <= n; x++) {
;;          ret = MULTIPLY(ret, x);
;;      }
;;      return ret;
;;  }

FACTORIAL ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the FACTORIAL subroutine here!
    ADD R6, R6, #-4 ;;ret value
    STR R7, R6, #2 ;;ret address
    STR R5, R6, #1 ;;old fp(frame pointer)
    ADD R5, R6, #0 ;;copies stack pointer to frame pointer
    ADD R6, R6, #-5 ;;make room for 5 registers

    STR R0, R5, #-1
    STR R1, R5, #-2
    STR R2, R5, #-3
    STR R3, R5, #-4
    STR R4, R5, #-5
    ;;Stack buildup factorial
    ;;Subroutine below
    AND R0, R0, 0 ;; return holder
    ADD R0, R0, 1

    AND R1, R1, 0 ;; ret
    ADD R1, R1, 2 ;; = 1

    LDR R2, R5, 4
    ADD R2, R2, 1
    NOT R2, R2
    ADD R2, R2, 1 ;;take complement

WH2 ADD R3, R1, R2 ;;x < = n
    BRzp ENDWH2
    ADD R6, R6, -2 ;;pushing x and ret while decrementing space in stack
    STR R0, R6, 0
    STR R1, R6, 1
    JSR MULTIPLY
    LDR R0, R6, 0
    ADD R6, R6, 3
    ADD R1, R1, 1
    BR WH2
ENDWH2 NOP
    STR R0, R5, 3
    ;;Stack tear down, fact subroutine
    LDR R4, R5, -5
    LDR R3, R5, -4
    LDR R2, R5, -3
    LDR R1, R5, -2
    LDR R0, R5, -1
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
    RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end