module Web.View.Tracks.Edit where
import Web.View.Prelude

data EditView = EditView { track :: Track }

instance View EditView where
    html EditView { .. } = [hsx|
        <div class="bg-slate-900/50 fixed top-0 left-0 right-0 bottom-0">
            <div class="mx-auto mt-8 w-96 rounded-md drop-shadow-md p-4 border-slate-50 bg-slate-100 dark:bg-slate-600
                        dark:text-slate-200">
                <h1>Edit Track</h1>
                {renderForm track}
            </div>
        </div>
    |]

inputStyle = "dark:bg-slate-200 shadow-inner text-slate-800"

renderForm :: Track -> Html
renderForm track = formFor track [hsx|
    {(textField #trackName) {fieldClass=inputStyle, autofocus=True}}
    {(textField #baseUrl) {fieldClass=inputStyle, fieldLabel="URL"}}
    Progress
    <div class="flex gap-4">
        {(textField #segmentName) {
            disableLabel=True, 
            fieldClass=inputStyle, 
            additionalAttributes = [("value", "Chapter")]}}
        <div class="w-2/3 flex items-center">
            {(numberField #segmentProgress) {
                disableLabel=True, 
                fieldClass=inputStyle,
                additionalAttributes = [ ("min", "0")]}}
            <span class="text-2xl pb-2">&nbsp;/&nbsp;</span>
            {(numberField #segmentCount) {
                disableLabel=True, 
                fieldClass=inputStyle,
                additionalAttributes = [ ("min", "1") ]}}
        </div>
        
    </div>
    {(checkboxField #isPaused)}

    {submitButton}

    <a class="mx-4" href={MyTracksAction}>Cancel</a>
    <a href={DeleteTrackAction track.id} class="js-delete text-muted">Delete</a>
|]