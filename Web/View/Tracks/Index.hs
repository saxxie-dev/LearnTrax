module Web.View.Tracks.Index where
import Web.View.Prelude

data IndexView = IndexView { tracks :: [Track]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
    <section class="overflow-auto grow flex flex-col divide-double divide-slate-300 dark:divide-slate-700 border-collapse dark:text-slate-400 text-slate-500">
        <div class="table table-fixed">
            <div class="table-row-group">
                {forEach completedTracks renderTrack}
            </div>
            <div class="table-row-group">
                {forEach wipTracks renderTrack}
            </div>
            <div class="table-row-group">
                {forEach pausedTracks renderTrack}
            </div>
        </div>
        <div class="m-auto"> 
            <a href={pathTo NewTrackAction} class="bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded">+ New Track</a>
        </div>
    </section>
        
    |] where 
        completedTracks = filter (\x -> x.segmentProgress >= x.segmentCount) tracks
        wipTracks = filter (\x -> x.segmentProgress < x.segmentCount && not x.isPaused) tracks
        pausedTracks = filter (\x -> x.isPaused) tracks

renderTrack :: Track -> Html
renderTrack track = [hsx|
    <div class="table-row
        hover:bg-slate-200 hover:dark:bg-slate-800 border-0 border-b
        dark:border-slate-600 border-slate-100 h-12">
        <div class="table-cell px-2 align-middle w-[20rem] overflow-hidden">
            <a href={track.baseUrl} class="hover:underline">
                {track.trackName}
            </a>
        </div>
        <div class="table-cell align-middle w-12">
            <a href={EditTrackAction track.id} class="hover:text-slate-400 hover:dark:text-slate-500 w-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="m14.06 9l.94.94L5.92 19H5v-.92L14.06 9m3.6-6c-.25 0-.51.1-.7.29l-1.83 1.83l3.75 3.75l1.83-1.83c.39-.39.39-1.04 0-1.41l-2.34-2.34c-.2-.2-.45-.29-.71-.29m-3.6 3.19L3 17.25V21h3.75L17.81 9.94l-3.75-3.75Z"/></svg>
            </a>
        </div>
        <div class="table-cell align-middle">
            <div class="flex flex-row items-middle gap-2 h-full">
                {renderCheckmarks track}
            </div> 
        </div>
    </div>
|]

renderCheckmarks :: Track -> Html 
renderCheckmarks track = [hsx|
    {forEach [(track.segmentOffset + 1).. (track.segmentCount)] (renderCheckmark track)}
|]

renderCheckmark :: Track -> Int -> Html 
renderCheckmark track x = 
    if x <= track.segmentProgress then [hsx|
        <form id="form" method="post" action={ProgressTrackAction track.id x}>
            <button class="w-8 h-8 rounded-md border font-bold flex
            items-center justify-around
            border-slate-600 dark:border-slate-300 text-teal-50 bg-teal-500 " type="submit">{x}</button>
        </form>      
    |] else if x == track.segmentProgress + 1 then [hsx|
        <form id="form" method="post" action={ProgressTrackAction track.id x}>
            <button class=" w-8 h-8 rounded-md border-slate-500 dark:border-slate-400 border font-bold flex
            items-center justify-around
            hover:border-slate-600 hover:dark:border-slate-300 hover:dark:text-teal-200 hover:text-teal-900
            hover:dark:bg-teal-900 hover:bg-teal-200" type="submit">{x}</button>
        </form>    
    |] else [hsx|
        <div class="w-8 h-8 rounded-md border-slate-500 dark:border-slate-400 border font-bold flex
        items-center justify-around">{x}</div>
    |]