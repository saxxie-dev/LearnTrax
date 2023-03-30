module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
        <div class="bg-teal-700 drop-shadow-xl">
            <h1 class="my-12 mx-auto text-center" style="font-weight: 900; font-size: 3rem">
                    Track your learning, in <i>style</i>
            </h1>
        </div>
        <div class="grow text-center">
            {contextualButtons}
        </div>

        <footer class="text-center text-sm text-slate-400 dark:text-slate-600 py-2">
            © 2023 <a class="hover:underline" href="https://saxxie.dev">saxxie.dev</a>
        </footer>

|] where contextualButtons = case currentUserOrNothing of
                    Just user -> [hsx|<div class="mt-20"><a class=" px-6 py-3 border bg-teal-700 font-bold hover:bg-teal-600 border-teal-600 rounded-lg mx-4 " href={MyTracksAction}>See my tracks</a></div>|]
                    Nothing -> [hsx|<div class="m-auto mt-12">
                                <a class="px-6 py-3 border bg-teal-700 border-teal-600 rounded-lg mx-4 hover:bg-teal-600" href={NewSessionAction}>Log in</a>
                                <a class="px-6 py-3 border border-teal-700 rounded-lg mx-4 hover:bg-slate-200 hover:dark:bg-slate-700" href={NewUserAction}>Sign up</a>
                            </div>|]