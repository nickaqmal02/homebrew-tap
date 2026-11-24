class Studynotch < Formula
  desc "Pomodoro timer and habit tracker that lives in your MacBook notch"
  homepage "https://github.com/nickaqmal02/ApexAgent"
  url "https://github.com/nickaqmal02/ApexAgent/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b22893be277b193bf7e5a554fd81904560c6f6b8ffbef329d25dcfee15c94719"
  license "MIT"

  depends_on macos: :ventura

  def install
    # SwiftPM has its own sandbox, which cannot run inside Homebrew's build sandbox
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "StudyNotch"
    bin.install ".build/release/StudyNotch" => "studynotch"
  end

  # `brew services start studynotch` runs it now and at every login
  service do
    run opt_bin/"studynotch"
    keep_alive successful_exit: false
    process_type :interactive
  end

  def caveats
    <<~EOS
      Start StudyNotch now and at every login:
        brew services start studynotch
      Then hover the notch at the top of your screen.
      Your data is kept in ~/Library/Application Support/StudyNotch/
    EOS
  end

  test do
    assert_path_exists bin/"studynotch"
    assert_predicate bin/"studynotch", :executable?
  end
end
