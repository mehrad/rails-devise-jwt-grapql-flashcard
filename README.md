# rails-devise-jwt-grapql-flashcard
A rails app with devise jwt and GraphQL to implement flashcard quiz like leitnerz box

## Live demo

### Front-End
 Here you cand find a sample react app to use this backend 
    https://boiling-reef-96946.herokuapp.com/
 ### Back-End
    https://fast-basin-51900.herokuapp.com/graphql

## GraphQL
Test these querys on localhost:4000/graphiql

1. To Get the authorisation code call this first.   

Either register a user

```
 mutation registerUser($email: String!, $password: String!) {
        registerUser(input: {email: $email, password: $password }) {
          user {
            id
            email
            authenticationToken
          }
          success
          errors
        }
      }
```

Or sign in 

```

    mutation signIn($email: String!, $password: String!) {
        signIn(input: { email: $email, password: $password }) {
          user {
            id
            firstName
            lastName
            authenticationToken
          }
          success
          errors
        }
      }
```

2. Then get active user with given autherization, set this with a ModHeader extesnion

```

  query Me {

      me {

        id
        email

      } 

    }

```

3. Now you can add box list this

```

 mutation AddBox($title: String!, $desc: String!) {
      	addBox(input: { title: $title, desc: $desc }) {
      	box {
      		id
      		title
      		desc
      		user {
      			id
      			email
      		}
      	}
      	success
      	errors
      	}
     }

```

Or delete

```
 mutation DeleteBox($id: ID!) {
      	deleteBox(input: { id: $id }) {
      	success
      	errors
      	}
      }
```

4. After that we can add flash cards to that box like this.

    be carefull to set the `boxId` correctly

```

mutation AddFlashcard($box_id: Int!, $question: String!, $answer: String!, $hint: String!, $tag_list: [String!]) {
      	addFlashcard(input: { boxId: $box_id, question: $question, answer: $answer, hint: $hint, tagList: $tag_list}) {
      	flashcard {
      		id
      		question
      		answer
      		tags
          hint
          house
          lastStudiedAt
      		box {
      			id
      			title
      		}
      	}
      	success
      	errors
      	}
      }

 ```

5. update flashcard like this 

```

 mutation UpdateFlashcard($box_id: Int!, $id: String!, $question: String!, $answer: String!, $tag_list: [String!]) {
      	updateFlashcard(input: { boxId: $box_id, id: $id, question: $question, answer: $answer , tagList: $tag_list}) {
      	flashcard {
      		id
      		question
      		answer
      		tags
      		box {
                        id
                        title
      		}
      	}
      	success
      	errors
      	}
      }
```

6. Also we can get all boxes of the current user like this:

```

query Box {

  boxes {

    id

    title

    flashcards {

      id

      question

    }

  }

}

```

7. We get all flashcards of all users like this

```

    query Flashcard {

      flashcards {

        id

        boxes

      }

    }

```

8. Now it would be the time to study start study a box 
   at first get available study cards for a box
   **boxId** must exists, we can also add offset and limit
   default offset and limit are zero and 20.
   like this:


```
query Studycard {
  studycards(boxId: 21) {
    id
    question
    answer
    house
    hint
    lastStudiedAt
  }
}

```

9. From here we can either levelup or reset a flashcard, if you know the answer to a study card level it up, on the other hand, reset it.


```

      mutation ResetCard($id: ID!) {
      	resetCard(input: { id: $id}) {
      	flashcard {
      		id
      		house
        }
      	success
      	errors
      	}
      }

``` 

```

mutation LevelUpCard($id: ID!) {
      	levelUpCard(input: { id: $id}) {
      	flashcard {
      		id
      		house
        }
      	success
      	errors
      	}
      }


```   

10. filter flashcards of the box like this:

```
query Flashcard {
  flashcards(boxId:14) {
    id
    box {
      id
      title
    }
  }
}
```

12. filter flashcards based on user or box or question or tag like this:

```

```

## Todos
* [ ] Add resolver or filter 
* [ ] Set up JWT

