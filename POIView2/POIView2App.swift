//
//  POIView2App.swift
//  POIView2
//
//  Created by Stuart Rankin on 11/4/26.
//

import SwiftUI

@main
struct POIView2App: App
{
    ///The user's own places. Entered and edited here, and sent to the watch whenever they change.
    @State private var Store: POIStore
    @State private var Link: WatchLink
    ///The radar's maximum range, set on the Settings tab and sent to the watch.
    @State private var Settings: RadarSettings

    init()
    {
        let TheStore = POIStore()
        _Store = State(initialValue: TheStore)
        let TheSettings = RadarSettings()
        _Settings = State(initialValue: TheSettings)
        _Link = State(initialValue: WatchLink(Store: TheStore, Settings: TheSettings))
    }

    var body: some Scene
    {
        WindowGroup
        {
            RootView()
                .environment(Store)
                .environment(Link)
                .environment(Settings)
        }
    }
}
