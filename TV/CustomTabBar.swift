//
//  CustomTabBar.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//

//
//  ContentView.swift
//  demo
//
//  Created by Htain Lin Shwe on 10/06/2025.
//

import SwiftUI

struct ContentsView: View {
    
    var body: some View {
        
        TabView {
            
            Tab("List",systemImage: "list.bullet") {
                // First Tab - List View
                NavigationView {
                    ListView()
                }
                
            }
            
            Tab("Setting",systemImage: "gear") {
                NavigationView {
                    SettingsView()
                }
            }
            Tab("Profle",systemImage: "person") {
                NavigationView {
                    ProfileView()
                }
            }
            Tab("search",systemImage: "magnifyingglass", role:.search) {
                NavigationView {
                    SearchView()
                }
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        
       
       
        
    }
                
}

struct ListView: View {
    let items = [
        "Apple", "Banana", "Cherry", "Date", "Elderberry",
        "Fig", "Grape", "Honeydew", "Kiwi", "Lemon",
        "Mango", "Orange", "Papaya", "Quince", "Raspberry"
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                Image("1001")
                    .resizable()
                    .aspectRatio(contentMode: .fill) // cover the frame
                    .frame(height: 200)
                    .clipped()
                LazyVStack(spacing: 12) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: DetailView(item: item)) {
                            HStack(spacing: 12) {
                                Image(systemName: "leaf.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.green)
                                    .padding(8)
                                    .background(Color.green.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text("Fruit")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes the default NavigationLink highlight
                    }
                }
                .padding(.horizontal)

                
            }
        }
            .toolbar {
                ToolbarItemGroup {
                    Button("share", systemImage: "square.and.arrow.up") {
                        
                    }
                   
                    Button("share", systemImage: "folder.fill.badge.plus") {
                        
                    }
                  
                    
                }
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                ToolbarItem(placement: .topBarTrailing) {
                    Button("create", systemImage: "pencil"){
                        
                    }
           
                }
            }
            .toolbar(removing: .title)
            .ignoresSafeArea(edges: .top)
            
        
        
    }
}

struct DetailView: View {
    let item: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Top image banner
                Image("1001")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 240)
                    .clipped()

                // Icon
                HStack {
                    Spacer()
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.green)
                    Spacer()
                }

                // Title
                Text(item)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                // Description
                Text("""
                    This is a detailed view for \(item). Below is some placeholder text to simulate a longer article or description. You can replace this with actual content such as recipes, news, or product details.

                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc sit amet fermentum consequat, nulla erat pretium libero, sed vehicula justo justo a lacus. Cras eget lacinia massa. Nulla facilisi. Donec eget facilisis ligula. 

                    Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse potenti. Duis vel cursus purus, sed bibendum turpis. Fusce porta justo non sem efficitur, at faucibus ipsum pulvinar.

                    Curabitur id nulla nec erat posuere sagittis. Integer feugiat vehicula turpis, nec fermentum libero interdum ut. Vivamus luctus mi sed risus bibendum, non ultricies lacus aliquam.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.bottom)
        }
        .toolbar(removing: .title)
        .ignoresSafeArea(edges: .top)
    }
}

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    
    var body: some View {
        Form {
            Section("Preferences") {
                Toggle("Notifications", isOn: $notificationsEnabled)
                Toggle("Dark Mode", isOn: $darkModeEnabled)
            }
            
            Section("About") {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SearchsView: View {
    @State private var searchText: String = ""
        
        // Sample data
        let items = ["Apple", "Banana", "Orange", "Mango", "Strawberry", "Watermelon"]

        // Computed filtered result
        var filteredItems: [String] {
            if searchText.isEmpty {
                return items
            } else {
                return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }

        var body: some View {
            NavigationView {
                List {
                    ForEach(filteredItems, id: \.self) { item in
                        NavigationLink(destination: Text("Detail view for \(item)")) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.blue)
                                Text(item)
                            }
                        }
                    }
                }
                .navigationTitle("Search")
                .searchable(text: $searchText)
            }
        }
}

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            Text("John Doe")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("iOS Developer")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("Edit Profile") {
                // Edit profile action
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationTitle("Profile")
    }
}


#Preview {
    ContentsView()
}
