//
//  ContentView.swift
//  marble
//
//  Created by Timothy Hu on 1/17/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var user: User?
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
                .frame(width:120, height: 120)
            
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "Bio Placeholder")
                .padding()
            
            Spacer()
            
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            }
            catch UserError.invalidURL{
                print("Invalid URL")
            }
            catch UserError.invalidResponse {
                print("Invalid Response")
            }
            catch UserError.invalidData {
                print("Invalid Data")
            }
            catch {
                print("Unexpected Error")
            }
        }
    }
    
}

#Preview {
    ContentView()
}

