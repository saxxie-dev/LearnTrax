module Web.View.Tracks.New where
import Web.View.Prelude

data NewView = NewView { track :: Track }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Track</h1>
        {renderForm track}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Tracks" TracksAction
                , breadcrumbText "New Track"
                ]

renderForm :: Track -> Html
renderForm track = formFor track [hsx|
    {(textField #userId)}
    {(textField #trackName)}
    {(textField #segmentCount)}
    {(textField #segmentOffset)}
    {(textField #segmentProgress)}
    {(textField #segmentName)}
    {(textField #baseUrl)}
    {(textField #isPaused)}
    {submitButton}

|]