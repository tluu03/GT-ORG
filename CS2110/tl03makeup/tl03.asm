;; Timed Lab 3
;; Student Name: Tony Luu

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA immediately.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;; // (checkpoint 1)
;; int MAX(int a, int b) {
;;   if (a > b) {
;;       return 0;
;;   } else {
;;       return 1;
;;   }
;; }
;;
;;
;;
;;
;; DIV(x, y) {
;;	   // (checkpoint 2) - Base Case
;;     if (y > x) {
;;         return 0;
;;     // (checkpoint 3) - Recursion
;;     } else {
;;         return 1 + DIV(x - y, y);
;;     }
;; }
;;
;;
;;
;; // (checkpoint 4)
;; void MAP(array, length) {
;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
;;   }
;; }


.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START MAX SUBROUTINE
MAX
; !!!!! WRITE YOUR CODE HERE !!!!!
    ADD R6, R6, #-4
	STR R7, R6, #2
	STR R5, R6, #1
	ADD R5, R6, #0
	ADD R6, R6, #-5
	STR R0, R6, #0
	STR R1, R6, #1
	STR R2, R6, #2
	STR R3, R6, #3
    STR R4, R6, #4
    ;;Start code
    LDR R0, R5, #4
    LDR R1, R5, #5
    NOT R1, R1
    ADD R1, R1, #1
    ADD R0, R0, R1
BRnz ELSE
    ;;RET 1
    AND R0, R0, #0
    STR R0, R5, #3
    BR TD2
ELSE
    AND R0, R0, #0
    ADD R0, R0, #1
    STR R0, R5, #3

TD2
    LDR R0, R6, #0
	LDR R1, R6, #1
	LDR R2, R6, #2
	LDR R3, R6, #3
	LDR R4, R6, #4
	ADD R6, R5, #0
	LDR R5, R6, #1
	LDR R7, R6, #2
	ADD R6, R6, #3

RET
; END MAX SUBROUTINE




; START DIV SUBROUTINE
DIV
;;R5, #4, x
;;R5, #5, y
; !!!!! WRITE YOUR CODE HERE !!!!!
    ADD R6, R6, #-4
	STR R7, R6, #2
	STR R5, R6, #1
	ADD R5, R6, #0
	ADD R6, R6, #-5
	STR R0, R6, #0
	STR R1, R6, #1
	STR R2, R6, #2
	STR R3, R6, #3
    STR R4, R6, #4
    ;;Code here
    LDR R0, R5, #4
    LDR R1, R5, #5
    NOT R2, R0
    ADD R2, R2, 1
    ADD R2, R2, R1
BRnz ELSE1
;;return 0
    AND R0, R0, #0
    STR R0, R5, #3
    BR TD1
ELSE1
    ;;Tentative
    LDR R0, R5, #4
    LDR R1, R5, #5
    NOT R2, R1
    ADD R2, R2, #1
    ADD R2, R0, R2

    ADD R6, R6, #-1
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    JSR DIV
    LDR R3, R6, #0
    ADD R6, R6, #3
    ADD R3, R3, #1
    STR R3, R5, #3
TD1
	LDR R0, R6, #0
	LDR R1, R6, #1
	LDR R2, R6, #2
	LDR R3, R6, #3
	LDR R4, R6, #4
	ADD R6, R5, #0
	LDR R5, R6, #1
	LDR R7, R6, #2
	ADD R6, R6, #3
RET
; END DIV SUBROUTINE



; START MAP SUBROUTINE
MAP
;;R5, #4, array
;;R5, #5, length

;;R5, #0, i
;;R5, #-1, firstElem
;;R5, #-2, secondElem
;;R5, #-3, div
;;R5, #-4, offset
; !!!!! WRITE YOUR CODE HERE !!!!!
    ADD R6, R6, #-4
	STR R7, R6, #2
	STR R5, R6, #1
	ADD R5, R6, #0
	ADD R6, R6, #-9
	STR R0, R6, #0
	STR R1, R6, #1
	STR R2, R6, #2
	STR R3, R6, #3
    ;;Code here
    AND R0, R0, #0
    STR R0, R5, #0
WHILE
    LDR R0, R5, #0
    LDR R1, R5, #5
    NOT R2, R1
    ADD R2, R2, #1
    ADD R0, R0, R2
BRzp ENDWH
;;firstElem = arr[i]
    LDR R0, R5, #0
    LDR R1, R5, #4
    ADD R1, R1, R0
    STR R1, R5, #-1
;;secondElem = arr[i + 1]
    ADD R0, R0, #1
    STR R1, R5, #-2
;;int div = DIV(firstElem, secondElem);
    LDR R3, R5, #-2
    LDR R4, R5, #-1
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    JSR DIV
    LDR R2, R6, #0
    ADD R6, R6, #3

;;int offset = MAX(firstElem, secondElem);
    LDR R3, R5, #-2
    LDR R4, R5, #-1
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    JSR MAX
    LDR R3, R6, #0
    ADD R6, R6, #3
;;arr[i + offset] = div;
    LDR R1, R5, #4
    ADD R1, R1, R0
    ADD R1, R1, R3
    STR R2, R1, #0  
    ;;i += 2; 
    ADD R0, R0, #2
BR WHILE
ENDWH


TEARDOWN
	LDR R0, R6, #0
	LDR R1, R6, #1
	LDR R2, R6, #2
	LDR R3, R6, #3
	LDR R4, R6, #4
	ADD R6, R5, #0
	LDR R5, R6, #1
	LDR R7, R6, #2
	ADD R6, R6, #3
RET
; END MAP SUBROUTINE


; LENGTH FOR TESTING

LENGTH .fill x12

; ARRAY FOR TESTING
ARRAY .fill x4000

.end

.orig x4000
.fill 12
.fill 3
.fill 5
.fill 7
.fill 16
.fill 2
.fill 5
.fill 5
.fill 25
.fill 7
.fill 48
.fill 60
.end
