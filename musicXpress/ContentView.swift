//
//  ContentView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/9/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
	@EnvironmentObject var audioManager: MediaPlayerManager
	
	@Namespace var namespace
	@State var show = false

    var body: some View {
		GeometryReader { geo in
			ZStack(alignment: .bottom) {
				TabView {
					HomeTabView()
						.tabItem {
							Label("Home", systemImage: "house")
						}
					ArtistTabView()
						.tabItem {
							Label("Artist", systemImage: "person")
						}
					AlbumTabView()
						.tabItem {
							Label("Album", systemImage: "opticaldisc")
						}
				}
				ZStack {
					if !show {
						NowPlayingBarView(namespace: namespace)
						.offset(x: 0, y: -48)
					}
					else {
						ExpandedNowPlayingView(namespace: namespace)
							.frame(maxWidth: UIScreen.main.bounds.width)
							.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded {
								value in
								if value.translation.height > 0 {
									withAnimation {
										show.toggle()
									}
								}
							})
					}
				}.onTapGesture {
					withAnimation {
						show.toggle()
					}
				}
			}
		}
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(show: true).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(AudioFileManager())
			.environmentObject(MediaPlayerManager())
            .preferredColorScheme(.dark)
    }
}
