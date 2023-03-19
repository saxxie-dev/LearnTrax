module Web.View.Tracks.Edit where
import Web.View.Prelude

data EditView = EditView { track :: Track }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Track</h1>
        {renderForm track}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Tracks" TracksAction
                , breadcrumbText "Edit Track"
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