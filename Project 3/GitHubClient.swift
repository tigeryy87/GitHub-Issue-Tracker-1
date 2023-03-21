//
//  GitHubClient.swift
//  Project 3
//
//  Created by Yin-Lin Chen on 2023/1/24.
//

// https://github.com/cobiwave/simplefolio/issues
// https://stackoverflow.com/questions/69624063/how-could-you-access-the-github-api-in-swift
import UIKit

import Foundation

struct Release: Decodable {
    let name: String
    let createdAt: String
    let author: Author
}

struct Author: Decodable {
    let login: String
}

struct GithubIssue: Codable {
    let title: String?
    let createdAt: String
    let body: String?
    let state: String
    let user: GitHubUser
}

struct GitHubUser: Codable {
    let login: String
}

class GitHubClient {
    
    static func fetchReleases(completion: @escaping ([Release]?, Error?) -> Void) {
        
        // Set the URL
        let url = URL(string: "https://api.github.com/repos/cobwaive/simplefolio/releases")!
        
        // Create a data task
        // https://cocoacasts.com/networking-fundamentals-how-to-make-an-http-request-in-swift
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                // If we are missing data, send back no data with an error
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            // Safely try to decode the JSON to our custom struct
            // https://developer.apple.com/documentation/foundation/jsondecoder
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let releases = try decoder.decode([Release].self, from: data)
                
                // If we're successful, send back our releases with no error
                DispatchQueue.main.async { completion(releases, nil) }
            } catch (let parsingError) {
                DispatchQueue.main.async { completion(nil, parsingError) }
            }
        }
        
        // Start the task (it begins suspended)
        task.resume()
    }
    static func fetchIssues(state: String, completion: @escaping ([GithubIssue]?, Error?) -> Void) {
        
        // Set the URL
        let url = URL(string: "https://api.github.com/repos/cobiwave/simplefolio/issues?state=\(state)")!
        
        // Create a data task
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                // If we are missing data, send back no data with an error
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            // Safely try to decode the JSON to our custom struct
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let releases = try decoder.decode([GithubIssue].self, from: data)
                
                // If we're successful, send back our releases with no error
                DispatchQueue.main.async { completion(releases, nil) }
                
            } catch (let parsingError) {
                DispatchQueue.main.async { completion(nil, parsingError) }
            }
        }
        
        // Start the task (it begins suspended)
        task.resume()
    }
}
