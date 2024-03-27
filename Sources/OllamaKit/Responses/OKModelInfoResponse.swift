//
//  OKModelInfoResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

public struct ModelDetails: Decodable {
    public let parent_model: String?
    public let format: String?
    public let family: String?
    public let families: [String]?
    public let parameter_size: String?
    public let quantization_level: String?
}

/// A structure that represents the response containing information about a specific model from the Ollama API.
// https://github.com/ollama/ollama/blob/main/docs/api.md#show-model-information
public struct OKModelInfoResponse: Decodable {
    /// A string detailing the licensing information for the model.
    public let license: String?
    
    /// A string containing the path or identifier of the model file.
    public let modelfile: String?
    
    /// A string detailing the parameters or settings of the model.
    public let parameters: String
    
    /// A string representing the template used by the model.
    public let template: String
    
    public let system: String?

    public let details: ModelDetails?
}
