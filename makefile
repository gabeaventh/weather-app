clean := false

brunner:
	@flutter pub run build_runner build --delete-conflicting-outputs

run:
ifeq ($(clean), true)
	@flutter clean && flutter pub get
	@flutter run
else
	@flutter run
endif

btest:
	@flutter test

itest:
	@flutter drive \
	--driver=test_driver/integration_test.dart \
	--target=integration_test/weather_app_integration_test.dart