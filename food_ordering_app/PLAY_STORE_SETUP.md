# Play Store Setup Guide for 1st Koko Spot

## Status
✅ App name updated: "1st Koko Spot"
✅ App icons generated for all platforms
✅ App package name: `com.kokospot.food_ordering_app`
✅ Signing keystore created: `android/app/koko_spot_release.keystore`
✅ Encryption key from Google Play Console: `encryption_public_key.pem`

## Next Steps

### Step 1: Encrypt Your Keystore (Run on Your Local Machine)

Run this command on your **local machine** (not in the cloud):

```bash
cd food_ordering_app

java -jar pepk.jar \
  --keystore=android/app/koko_spot_release.keystore \
  --alias=koko_spot_key \
  --output=encrypted_keystore.zip \
  --encryptionkey=encryption_public_key.pem
```

When prompted:
- **Keystore password**: `kokospot123`
- **Key password**: `kokospot123`

This will generate `encrypted_keystore.zip`

### Step 2: Upload Keystore to Google Play Console

1. Go to Google Play Console → Your App
2. Navigate to **Release** → **Setup** → **App Signing**
3. Upload the `encrypted_keystore.zip` file
4. Google Play Console will manage all future signing

### Step 3: Build and Upload AAB

Once the keystore is registered with Play Console, build the AAB:

```bash
flutter build appbundle --release
```

The built AAB will be at:
```
build/app/outputs/bundle/release/app-release.aab
```

Upload this to Google Play Console for testing.

## Keystore Details

- **Keystore File**: `android/app/koko_spot_release.keystore`
- **Key Alias**: `koko_spot_key`
- **Passwords**: `kokospot123` (both store and key password)
- **Validity**: 10,000 days
- **Algorithm**: RSA 2048-bit
- **Company**: 1st Koko
- **Location**: Lagos, Nigeria

## Files Included

- `android/app/koko_spot_release.keystore` - Your signing keystore
- `encryption_public_key.pem` - Encryption key from Play Console
- `pepk.jar` - Tool to encrypt the keystore
- `android/key.properties` - Gradle signing configuration

## Troubleshooting

**Issue**: pepk.jar fails in terminal
**Solution**: Run pepk locally on your machine with a real terminal

**Issue**: Wrong package name
**Current**: `com.kokospot.food_ordering_app`
**Change**: Edit `android/app/build.gradle.kts` applicationId field

**Issue**: App signing fails after uploading keystore
**Solution**: Make sure Play Console has processed the keystore upload before building AAB

## Additional Resources

- [Google Play App Signing](https://developer.android.com/studio/publish/app-signing#play-app-signing)
- [Flutter Release Build](https://flutter.dev/docs/deployment/android#build-an-app-bundle)
- [Google Play Console Help](https://support.google.com/googleplay)
