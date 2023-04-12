// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "oh_queue.h"

struct Queue oh_queue;

/** push
 * @brief Create a new student and push him
 * onto the OH queue
 * @param studentName pointer to the student's name
 * @param topicName topic the student has a question on
 * @param questionNumber hw question number student has a question on
 * @param pub_key public key used for calculating the hash for customID
 * @return FAILURE if the queue is already at max length, SUCCESS otherwise
 */
int push(const char *studentName, const enum subject topicName, const float questionNumber, struct public_key pub_key){
    struct Student s1;
    int people_in_queue = oh_queue.stats.no_of_people_in_queue;

    if(*studentName == '\0' || people_in_queue + 1 > MAX_NAME_LENGTH) {
        return FAILURE;
    }
    int name_length = my_strlen(studentName);
    if(name_length >= MAX_NAME_LENGTH) {
        name_length = MAX_NAME_LENGTH - 1;
    }
    for(int i = 0; i < name_length; i++) {
        s1.studentData.name[i] = studentName[i];
    }

    s1.studentData.name[name_length] = '\0';

    hash(s1.customID, s1.studentData.name, pub_key);
    int queue_number = queue_number + 0;

    s1.studentData.topic.topicName = (enum subject) topicName;
    s1.studentData.topic.questionNumber = questionNumber;
    oh_queue.students[oh_queue.stats.no_of_people_in_queue] = s1;
    oh_queue.stats.no_of_people_in_queue += 1;

    if(oh_queue.stats.no_of_people_in_queue == 0) {
        oh_queue.stats.currentStatus = "Complete";
    }
    else {
        oh_queue.stats.currentStatus = "WIP";
    }
    return SUCCESS;
}

/** pop
 * @brief Pop a student out the OH queue
 * @return FAILURE if the queue is already at empty, SUCCESS otherwise
 */
int pop(void) {
    if(oh_queue.stats.no_of_people_in_queue == 0){
        return FAILURE;
    }
    for(int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        oh_queue.students[i] = oh_queue.students[i+1];
    }
    oh_queue.stats.no_of_people_in_queue = oh_queue.stats.no_of_people_in_queue - 1;
    oh_queue.stats.no_of_people_visited = oh_queue.stats.no_of_people_visited + 1;
    
    if(oh_queue.stats.no_of_people_in_queue == 0) {
        oh_queue.stats.currentStatus = "Complete";
    } else {
        oh_queue.stats.currentStatus = "WIP";
    }
    return SUCCESS;
}

/** group_by_topic
 * @brief Push pointers to students, who match the given topic, to
 * the given array "grouped"
 * @param topic the topic the students need to match
 * @param grouped an array of pointers to students
 * @return the number of students matched
 */
int group_by_topic(struct Topic topic, struct Student *grouped[]) { 
    UNUSED_PARAM(topic);
    UNUSED_PARAM(grouped);

    return 0;
}

/** hash
 * @brief Creates a hash based on pub_key provided
 * @param ciphertext the pointer where you will store the hashed text
 * @param plaintext the originak text you need to hash
 * @param pub_key public key used for calculating the hash
 */
void hash(int *ciphertext, char *plaintext, struct public_key pub_key) {
    UNUSED_PARAM(ciphertext);
    UNUSED_PARAM(plaintext);
    UNUSED_PARAM(pub_key);
    int plaintext_length = my_strlen(plaintext);
    int c;
    for(int i = 0; i < plaintext_length; i++) {
        c = power_and_mod(*(plaintext + i), pub_key.e, pub_key.n);
        *(ciphertext + i) = c;
    }
}

/** update_student
 * @brief Find the student with the given ID and update his topic
 * @param customID a pointer to the id of the student you are trying to find
 * @param newTopic the new topic that should be assigned to him
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int update_student(struct Topic newTopic, int *customID) {
    for(int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        for(int j = 0; j < 30; j++) {
            if(oh_queue.students[i].customID[j] != customID[j]) {
                break;
            }
            if (oh_queue.students[i].customID[j] == 0 || customID[j] == 0) {
                oh_queue.students[i].studentData.topic.topicName = newTopic.questionNumber;
                oh_queue.students[i].studentData.topic.questionNumber = newTopic.questionNumber;
                return SUCCESS;
            }
        }
    }
    
    return FAILURE;
}

/** remove_student_by_name
 * @brief Removes first instance of a student with the given name
 * @param name the name you are searching for
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_name(char *name){
    UNUSED_PARAM(name);

    return SUCCESS;
}

/** remove_student_by_topic
 * @brief Remove all instances of students with the given topic
 * @param topic the topic you are trying to remove from the queue
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_topic(struct Topic topic) {
    UNUSED_PARAM(topic);

    return SUCCESS;
}

/** OfficeHoursStatus
 * @brief Updates the "currentStatus" field based on
 * whether or not all students in the queue have been helped
 * @param resultStats A pointer the OfficeHoursStats variable
 * you are to update
 */
void OfficeHoursStatus(struct OfficeHoursStats* resultStats ){
    UNUSED_PARAM(resultStats);

    return;
}

/*
 * Calculates (b^e)%n without overflow
 */
int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) (currNum % n);
}
