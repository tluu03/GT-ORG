;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Tony Luu
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  boolean isPalindrome = true
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0
;;  int right = length - 1
;;  while(left < right) {
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;			break;
;;		}
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000
	;; YOUR CODE HERE
	AND R0, R0, 0 ;; length
	AND R1, R1, 0 ;;palindrome
	ADD R1, R1, 1
WH1 LD R2, STRING
    ADD R2, R2, R0
    LDR R3, R2, 0

    BRz ENDWH1

    ADD R0,R0,1

    BRnp WH1
ENDWH1
    AND R4, R4, 0
    ADD R4, R4, 0
    ADD R5, R0, -1

WH2 LD R6, STRING
    ADD R6, R6, R4
    LDR R7, R6, 0

    LD R6, STRING
    ADD R6, R6, R5
    LDR R3, R6, 0

    NOT R3, R3
    ADD R3, R3, 1

    ADD R3, R3, R7

    BRnp NOTPAL

    BR NEXT
NOTPAL
    AND R1, R1, 0
    STI R1, ANSWERADDR
    HALT
NEXT
    ADD R4, R4, 1
    ADD R5, R5, -1

    BR WH2

    STI R1, ANSWERADDR
	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004				   
	.stringz "aibohphobia" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end