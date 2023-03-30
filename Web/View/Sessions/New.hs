module Web.View.Sessions.New where
import Web.View.Prelude
import IHP.AuthSupport.View.Sessions.New

instance View (NewView User) where
    html NewView { .. } = [hsx|
        <section class="w-96 mx-auto mt-12 p-12 pt-8 bg-slate-200 dark:bg-slate-800 rounded-md border border-slate-300 dark:border-slate-700 flex flex-col mb-8">
            <h1 class="text-lg">Log in:</h1>
            {renderForm user}
        </section>
    |]

renderForm :: User -> Html
renderForm user = [hsx|
    <form method="POST" action={CreateSessionAction}>
        <div class="form-group">
            <input name="email" value={user.email} type="email" class={inputStyle} placeholder="E-Mail" required="required" autofocus="autofocus" />
        </div>
        <div class="form-group">
            <input name="password" type="password" class={inputStyle} placeholder="Password"/>
        </div>
        <button type="submit" class="bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded mt-4">Log in</button>
        <a href={NewUserAction} class="px-4 py-2 border border-teal-700 rounded mx-4 hover:bg-slate-200 hover:dark:bg-slate-700">Sign up</a>
    </form>
|]

inputStyle :: String;
inputStyle = "dark:bg-slate-200 shadow-inner text-slate-800 rounded-md w-full my-2"
-- renderForm :: User -> Html
-- renderForm user = formFor user [hsx|
--     {(textField #email) {fieldClass=inputStyle}}
--     <div class="flex gap-4">
--         {(passwordField #passwordHash) {fieldLabel= "Password", fieldClass=inputStyle}}
--         {(passwordField #passwordHash) {fieldName="password2", fieldLabel= "Confirm Password", fieldClass=inputStyle}}
--     </div>
--     {submitButton}
-- |]
