;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Insertion Sort
;;=============================================================
;;  Name: Tony Luu
;;============================================================

;;  In this file, you must implement the 'INSERTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'INSERTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * INSERTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  INSERTION_SORT **RESURSIVE** Pseudocode (see PDF for explanation and examples)
;; 
;;  INSERTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;        return;
;;      }
;;  
;;      INSERTION_SORT(arr, length - 1);
;;  
;;      int last_element = arr[length - 1];
;;      int n = length - 2;
;;  
;;      while (n >= 0 && arr[n] > last_element) {
;;          arr[n + 1] = arr[n];
;;          n--;
;;      }
;;  
;;      arr[n + 1] = last_element;
;;  }

INSERTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the INSERTION_SORT subroutine here!
    ;; NOTE: Your implementation MUST be done recursively
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

    ;;insertionSort subroutine
    LDR R0, R5, #4 ;; int[R0] arr
    LDR R1, R5, #5 ;; length = R1

    NOT R1, R1 ;; get length complement
    ADD R1, R1, #1

    BRzp END
    BR CONT
CONT
    LDR R0, R5, #4 ;;R0 = arr
    LDR R1, R5, #5 ;;R1 is length
    ADD R1, R1, #-1;; length - 1

    ADD R6, R6, #-1 ;;decrement R6
    STR R1, R6, #0 ;; push length

    ADD R6, R6, #-1 ;;decrement
    STR R0, R6, #0 ;;push array
    JSR INSERTION_SORT

    ADD R6, R6, #1 ;;pop first val
    ADD R6, R6, #2 ;;pop arr

    LDR R0, R5, #4 ;;R3 = int[] arr

    LDR R2, R5, #5 ;; R2 = length
    ADD R2, R2, #-1 ;; length - 1

    ADD R4, R0, R2 ;;find arr[length - 1]
    LDR R4, R4, #0
    
    ADD R2, R2, #-1 ;;decrement length
WH
    ADD R2, R2, #0 ;;n >= 0
    BRn ENDWH

    LDR R3, R5, #4 ;;int[] arr
    ADD R3, R3, R2 
    LDR R3, R3, #0 ;;arr[n]
    
    ;;flip
    NOT R1, R4 ;;R1 = -last_element
    ADD R1, R1, #1

    ADD R0, R3, R1 ;;arr[n] - last
    ;;one condition
    BRnz ENDWH

    ADD R2, R2, #1 ;; n + 1

    LDR R0, R5, #4 ;; R0 = int[] arr
    ADD R0, R0, R2 ;; R0 is now where arr[n + 1]
    ;;tbh follow pseudo

    STR R3, R0, #0 ;; arr[n + 1] = arr[n]

    ADD R2, R2, #-1 ;; R2 = n + 1 - 1 = n
    ADD R2, R2, #-1 ;; n--;

    BR WH
ENDWH

    ADD R4, R4, #0 ;;R4 = last_element
    ADD R2, R2, #1 ;;n + 1
    
    LDR R0, R5, #4 ;;R0 = int[] arr
    ADD R0, R0, R2 ;;R0 is address of arr[n + 1]

    STR R4, R0, #0
END
    ;;beginning of teardown
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

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end