/**
 * @file my_string.c
 * @author Tony Luu
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-29
 */

#include <stddef.h>
#include "my_string.h"
/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    size_t length = 0;
    int index = 0;
    while ( *(s + index) != '\0') {
        length++;
        index++;
    }
    
    return length;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    size_t index = 0;
    while (*s1 && *s2 && *s1 == *s2 && index < n) {
        s1++;
        s2++;
        index++;
    }
    int diff = *s1 - *s2;
    return diff;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    size_t index = 0;
    while (index < n && (*src + index != '\0')) {
        *(dest + index) = *(src + index);
        index++;
    }
    while (index < n) {
        *(dest + index) = '\0';
        index++;
    }
    return dest;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    size_t index = 0;
    while (*(dest + index) != '\0' && index < n) {
        index++;
    }
    size_t index2 = 0;
    while ((*(src + index2) != '\0') && index2 < n) {
        *(dest + index + index2) = *(src + index2);
        index2++;
    }

    if (index2 < n) {
        *(dest + index) = '\0';
    }
    return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    unsigned char *p = str;
    while (n > 0) {
        *p = c;
        p++;
        n--;
    }
    return str;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c){
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    char *cpoint = str;
    while (*cpoint != '\0' && *cpoint != c) {
        cpoint++;
    }
    if (*cpoint == c) {
        char *nextPoint = cpoint + 1;
        while (*nextPoint != '\0') {
            *cpoint = *nextPoint;
            cpoint++;
            nextPoint++;
        }
        *cpoint = '\0';
    }
}

/**
 * @brief Finds the first instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr) {
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    UNUSED_PARAM(str);
    UNUSED_PARAM(c);
    UNUSED_PARAM(replaceStr);
    
    return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    if (*str == NULL || **str == '\0') {
        return;
    }
    char *temp = *str;
    (*str)++;
    while (*temp != '\0') {
        *temp = *(temp+1);
        temp++;
    }
    *temp = '\0';
}