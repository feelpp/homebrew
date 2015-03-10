class YamlCpp < Formula
  homepage "https://code.google.com/p/yaml-cpp/"
  url "https://yaml-cpp.googlecode.com/files/yaml-cpp-0.5.1.tar.gz"
  sha256 "3e7c9052b43d987d41819a203d97fc45de4eed3ec67e0fdb14265c3d11046f06"

  bottle do
    cellar :any
    sha1 "84e9938ac85d1830acb4c15b6eb3b4a33ec33a33" => :yosemite
    sha1 "c085fa37570254c346b16e7c62f962775f992389" => :mavericks
    sha1 "bcd0894e3abc4db1ddc9d1df0a3c24117f189f74" => :mountain_lion
  end

  option :cxx11
  option :universal
  option "with-static-lib", "Build a static library"

  depends_on "cmake" => :build

  if build.cxx11?
    depends_on "boost" => "c++11"
  else
    depends_on "boost"
  end

  def install
    ENV.cxx11 if build.cxx11?
    ENV.universal_binary if build.universal?
    args = std_cmake_args
    if build.with? "static-lib"
      args << "-DBUILD_SHARED_LIBS=OFF"
    else
      args << "-DBUILD_SHARED_LIBS=ON"
    end

    system "cmake", ".", *args
    system "make", "install"
  end
end
