//
//  ContentView.swift
//  MetaCollaboration
//
//  Created by Tomáš Šmerda on 22.01.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: CollaborationViewModel
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
                    .scaleEffect(1.5)
                    .zIndex(2)
            }
            
            TabView {
                if UserDefaults.standard.string(forKey: "appMode") != "onlineMode" {
                    DatasetListView()
                        .environmentObject(viewModel)
                        .tabItem {
                            Label("Menu", systemImage: "list.dash")
                        }
                }
                
                ZStack(alignment: .center) {
                    CollaborationView()
                        .environmentObject(viewModel)
                        .zIndex(1)
                        .sheet(isPresented: $showingSheet) {
                            GuideView(guide: $viewModel.currentGuide)
                        }
                    
                    //                     ARViewContainer()
                    //                        .environmentObject(viewModel)
                    //                        .zIndex(1)
                    
                    VStack {
                        Button(action: {
                            self.showingSheet = true
                        }) {
                            Text(viewModel.ARResults)
                                .frame(width: UIScreen.main.bounds.width - 15, height: 80)
                                .background(.white)
                                .foregroundColor(.black)
                                .padding(.top, 30)
                        }
                        
                        Spacer()
                    }
                    .zIndex(2)
                }
                .tabItem {
                    Label("Collaboration", systemImage: "viewfinder")
                }
                
                InfoView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("Info", systemImage: "info.circle")
                    }
            }
        }
        .onAppear() {
            viewModel.getGuideById(id: "640b700f16cde6145a3bfc19")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
