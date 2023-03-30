module Web.Controller.Tracks where

import Web.Controller.Prelude
import Web.View.Tracks.Index
import Web.View.Tracks.New
import Web.View.Tracks.Edit

instance Controller TracksController where
    beforeAction = ensureIsUser
    action MyTracksAction = do
        redirectTo TracksAction { userId = currentUserId }

    action TracksAction { .. } = do
        tracks <- query @Track 
            |> filterWhere (#userId, userId)
            |> fetch
        render IndexView { .. }

    action NewTrackAction = do
        let track = newRecord |> set #segmentCount 1
        setModal NewView { .. }
        jumpToAction (TracksAction currentUserId)

    action EditTrackAction { trackId } = do
        track <- fetch trackId
        setModal EditView { .. }
        jumpToAction (TracksAction currentUserId)

    action UpdateTrackAction { trackId } = do
        track <- fetch trackId
        track
            |> buildTrack
            |> ifValid \case
                Left track -> render EditView { .. }
                Right track -> do
                    track <- track |> updateRecord
                    redirectTo (TracksAction currentUserId)
    
    action ProgressTrackAction { trackId, num } = do 
        track <- fetch trackId
        track
            |> set #segmentProgress num
            |> updateRecord
        redirectTo (TracksAction currentUserId)

    action CreateTrackAction = do
        let track = newRecord @Track
        track
            |> buildTrack
            |> set #userId (currentUserId)
            |> validateField #trackName nonEmpty
            |> validateField #segmentCount (isGreaterThan 0)
            |> validateField #segmentProgress (isGreaterThan (-1))
            |> validateField #segmentProgress (isLessThan $ (1 + param "segmentCount"))
            |> ifValid \case
                Left track -> render NewView { .. } 
                Right track -> do
                    track <- track 
                        |> set #segmentOffset track.segmentProgress
                        |> createRecord
                    redirectTo TracksAction { userId = currentUserId}

    action DeleteTrackAction { trackId } = do
        track <- fetch trackId
        deleteRecord track
        setSuccessMessage "Track deleted"
        redirectTo TracksAction { userId = currentUserId}

buildTrack track = track
    |> fill @["userId", "trackName", "segmentCount", "segmentOffset", "segmentProgress", "segmentName", "baseUrl", "isPaused"]
