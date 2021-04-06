# rails-devise-jwt-grapql-flashcard
A rails app with devise jwt and GraphQL to implement flashcard quiz like leitnerz box 

## GraphQL
Test these querys on localhost:4000/graphiql

1. To Get the authorisation code call this first.   

```

    mutation SignIn{

    	signIn(

        input: {

          email:"maosud@gmail.com"

          password: "123123123"

        }

      ) {

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

      } 

    }

```

3. Now you can add box list this

```

mutation AddBox {

  addBox(input: {title: "test title", desc:"test desc"}) {

    box {

      id

      title

      desc

      user {

        id

        email

      }

    }

  }

}

```

4. After that we can add flash cards to that box like this.

    be carefull to set the `boxId` correctly

```

  mutation AddFlashcard {

  addFlashcard(input: {boxId: 1, question: "q2", answer: "a", hint, "hint", tagList: ["box1", "box"]}) {

    flashcard {

      id

      question

      answer
      
      hint
     
      house

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

 mutation UpdateFlashcard {

  updateFlashcard(input: { boxId: 1, id: "3", question: "q1", answer: "a1", tagList: ["bt1", "bt2"]}) {

    flashcard {

      id

      question

      answer

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

mutation ResetCard {
  resetCard(input: {id: 20}) {
     flashcard {
      id
      house
      question
      answer
    }
  }
}

``` 

```

mutation LevelUpCard {
  levelUpCard(input: {id: 20}) {
     flashcard {
      id
      house
      question
      answer
    }
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
