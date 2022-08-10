Pod::Spec.new do |spec|
  spec.name         = "ToDoItemModel"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library"
  spec.description  = <<-DESC
    A CocoaPods library for ToDoList App
                   DESC
  spec.homepage     = "https://github.com/Aeeson/ToDoItemModel"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Aeeson" => "aeeson@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.6.1"
  spec.source       = { :git => "https://github.com/Aeeson/ToDoItemModel.git", :tag => "#{spec.version}" }
  spec.source_files  = "ToDoItemModel/**/*.{h,m,swift}"
  spec.resources = "ToDoItemModel/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
end
