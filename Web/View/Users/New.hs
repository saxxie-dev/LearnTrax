module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where
    html NewView { .. } = [hsx|
        <section class="w-96 mx-auto mt-12 p-12 pt-8 bg-slate-200 dark:bg-slate-800 rounded-md border border-slate-300 dark:border-slate-700">
            <h1 class="text-lg">New User</h1>
            {renderForm user}
        </section>
    |]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #email) {fieldClass=inputStyle}}
    <div class="flex gap-4">
        {(passwordField #passwordHash) {fieldLabel= "Password", fieldClass=inputStyle}}
        {(passwordField #passwordHash) {fieldName="password2", fieldLabel= "Confirm Password", fieldClass=inputStyle}}
    </div>
    {submitButton}
|]

inputStyle = "dark:bg-slate-200 shadow-inner text-slate-800"