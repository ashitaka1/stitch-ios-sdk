Pod::Spec.new do |s|
  s.name         = "ExtendedJson"
  s.version      = "0.0.1"
  s.summary      = "A helper library to serialize and de-serialize Extended JSON to communicate with MongoDB's BaaS."
  s.license      = {
  						:type => "MIT",
  						:file => "LICENSE.md"
  				   }
  s.platform     = :ios, "9.0"
  s.authors		 = "MongoDB"
  s.homepage     = "https://stitch.mongodb.com"
  s.source       = { 
  						:git => "https://git.zemingo.com/MongoBaaS/mongo-baas-core-ios.git", 
  						:tag => "#{s.version}"
  				   }
  s.source_files  = "ExtendedJson/ExtendedJson/**/*.swift"
  s.requires_arc = true
  s.dependency "StitchLogger", "~> 0.0.1"
end