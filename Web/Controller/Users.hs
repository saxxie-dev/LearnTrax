module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.New

instance Controller UsersController where

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action CreateUserAction = do
        let user = newRecord @User
        user
            |> fill @["email", "passwordHash"]
            |> validateField #email isEmail
            |> validateField #passwordHash nonEmpty
            |> validateField #passwordHash (hasMinLength 8)
            |> validateField #passwordHash (passwordMatch (param "password2"))
            |> validateIsUniqueCaseInsensitive #email
            >>= ifValid \case
                Left user -> render NewView { .. }
                Right user -> do
                    hashed <- hashPassword user.passwordHash
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "You have registered successfully"
                    redirectToPath "/"

    action DeleteUserAction { userId } = do
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo WelcomeAction
        
buildUser user = user
    |> fill @["email", "passwordHash", "failedLoginAttempts"]


passwordMatch :: Eq a => a -> a -> ValidatorResult
passwordMatch pw1 pw2 = if pw1 == pw2 then Success else Failure "Password doesn't match"