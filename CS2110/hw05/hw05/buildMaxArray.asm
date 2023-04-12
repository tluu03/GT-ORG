;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Tony Luu
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;	int A[] = {-2, 2, 1};
;;	int B[] = {1, 0, 3};
;;	int C[3];
;;	int length = 3;
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] >= B[length - i - 1]) {
;;			C[i] = 1;
;;		}
;;		else {
;;			C[i] = 0;
;;		}
;;		i++;
;;	}

.orig x3000
	;; YOUR CODE HERE
    AND R0, R0, #0;;i
    AND R1, R1, #0;;length

WH  LD R1, LENGTH ;;code for i < length and start of while
    NOT R1, R1 ;start twos complement
    ADD R1, R1, #1 ;add one to length
    ADD R1, R0, R1 ;i + inverted length for i - length
    BRzp DONE ;if negative, carry on, if not, skip to DONE
    ;;while body
    LD R2, A;;A[i] lines
    ADD R2, R2, R0
    LDR R3, R2, #0

    ;;b[length - i - 1]
    LD R4, B
    NOT R1, R1 ;take the not of R1 to get the equivalent of length - i - 1
    ADD R4, R4, R1
    LDR R5, R4, #0

    ;;if statement
    NOT R5, R5
    ADD R5, R5, #1
    ADD R3, R3, R5
    BRn ELSE1 ;; if negative, go to else1

    ;;then statement
    LD R6, C
    ADD R6, R6, R0
    AND R4, R4, #0
    ADD R4, R4, #1
    STR R4, R6, #0

    BR ENDWH
ELSE1 ;;else
    ;;else statement
    LD R6, C
    ADD R6, R6, R0
    AND R4, R4, #0
    STR R4, R6, #0
    BR ENDWH
ENDWH ADD R0, R0, #1 ;;endwhile and i++
    BR WH
    DONE
	HALT

;; Do not change these addresses!
;; We populate A and B and reserve space for C at these specific addresses in the orig statements below.
A 		.fill x3200
B 		.fill x3300
C 		.fill x3400
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -2
	.fill 2
	.fill 1
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 0
	.fill 3
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end