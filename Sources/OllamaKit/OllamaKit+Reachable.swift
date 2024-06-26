//
//  OllamaKit+Reachable.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Alamofire
import Combine
import Foundation

extension OllamaKit {
    /// Asynchronously checks if the Ollama API is reachable.
    ///
    /// This method attempts to make a network request to the Ollama API. It returns `true` if the request is successful, indicating that the API is reachable. Otherwise, it returns `false`.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    /// let isReachable = await ollamaKit.reachable()
    /// ```
    ///
    /// - Returns: `true` if the Ollama API is reachable, `false` otherwise.
    public func reachable(timeoutInterval: TimeInterval = 2.0) async -> Bool {
        var urlRequest: URLRequest = try! router.root.asURLRequest()
        urlRequest.timeoutInterval = timeoutInterval
        
        let request = self.session.request(urlRequest).validate()
        
        do {
            _ = try await request.serializingData().value
            
            return true
        } catch {
            return false
        }
    }
    
    /// Checks if the Ollama API is reachable, returning the result as a Combine publisher.
    ///
    /// This method performs a network request to the Ollama API and returns a Combine publisher that emits `true` if the API is reachable. In case of any errors, it emits `false`.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    /// 
    /// ollamaKit.reachable()
    ///     .sink(receiveValue: { isReachable in
    ///         // Handle the reachability status
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Returns: A `AnyPublisher<Bool, Never>` that emits `true` if the API is reachable, `false` otherwise.
    public func reachable() -> AnyPublisher<Bool, Never> {
        let request = self.session.request(router.root).validate()
        
        return request.publishData().value()
            .map { _ in true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
