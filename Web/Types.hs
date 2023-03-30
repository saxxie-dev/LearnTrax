module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

data UsersController
    = NewUserAction
    | CreateUserAction
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)

data TracksController
    = MyTracksAction
    | TracksAction { userId :: !(Id User) }
    | NewTrackAction
    | CreateTrackAction
    | ProgressTrackAction { trackId :: !(Id Track), num :: Int}
    | EditTrackAction { trackId :: !(Id Track) }
    | UpdateTrackAction { trackId :: !(Id Track) }
    | DeleteTrackAction { trackId :: !(Id Track) }
    deriving (Eq, Show, Data)
