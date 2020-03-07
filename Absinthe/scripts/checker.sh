RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
RESET='\033[0m'       # Text Reset
function __system {
    echo -e $GREEN$*$RESET
}
function __error {
    echo -e $RED$*$RESET
}

echo ""
__system "Run xunique 🏃‍♀️🏃‍♀️🏃‍♀️"
echo "xunique Absinthe.xcodeproj"
if ! xunique Absinthe.xcodeproj; then
    __error "Found xunique errors"
else
    __system "Done 🤟"
fi


echo ""
cd ..
__system "Run swiftlint  🏃‍♀️🏃‍♀️🏃‍♀️"
if ! swiftlint --strict --quiet; then
  __error "Found lint errors"
  __system "Run autocorrect.."
  echo "swiftlint autocorrect --quiet"
  swiftlint autocorrect --quiet
else
  __system "Done 🤟"
fi
