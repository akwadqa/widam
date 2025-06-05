import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widam/src/features/addresses/data/google_maps_repository.dart';
import 'package:widam/src/features/addresses/domain/place/place.dart';
import 'package:widam/src/network/services/network_service.dart';

class MockNetworkService extends Mock implements NetworkService {
  @override
  Future<Response> get(String url, {dynamic data, Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
   CancelToken? cancelToken}) async {
    if(queryParameters?['input'] != null && queryParameters?['input'] != '') {
      return Response(data: _kSuccessResponse, requestOptions: RequestOptions());
    }else {
      return Response(data: _kInvalidRequestResponse, requestOptions: RequestOptions());
    }
  }
}

void main() {
  GoogleMapsRepository? repository;

  ProviderContainer? providerContainer;
  final mockNetworkService = MockNetworkService();
  const mockSessionToken = 'abcdefg';

  setUp(() => {
    providerContainer = ProviderContainer(
      overrides: [
        googleMapsRepositoryProvider.overrideWithValue(GoogleMapsRepository(mockNetworkService)),
      ],
    ),
    repository = providerContainer!.read(googleMapsRepositoryProvider),
  });

  test('should call Google Maps API and return a list of Places', () async {
    //Arrange
    const mockInput = 'Eiffel Tower';

    // Act
    final result = await repository!.autoComplete(mockInput, mockSessionToken);

    // Assert
    expect(result, isA<List<Place>>());
  });

  tearDown(() => providerContainer!.dispose());
}

const _kSuccessResponse = {
  "predictions": [
    {
      "description": "Paris, France",
      "matched_substrings": [
        {
          "length": 5,
          "offset": 0
        }
      ],
      "place_id": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
      "reference": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
      "structured_formatting": {
        "main_text": "Paris",
        "main_text_matched_substrings": [
          {
            "length": 5,
            "offset": 0
          }
        ],
        "secondary_text": "France"
      },
      "terms": [
        {
          "offset": 0,
          "value": "Paris"
        },
        {
          "offset": 7,
          "value": "France"
        }
      ],
      "types": [
        "locality",
        "political",
        "geocode"
      ]
    },
    {
      "description": "Paris, TX, USA",
      "matched_substrings": [
        {
          "length": 5,
          "offset": 0
        }
      ],
      "place_id": "ChIJmysnFgZYSoYRSfPTL2YJuck",
      "reference": "ChIJmysnFgZYSoYRSfPTL2YJuck",
      "structured_formatting": {
        "main_text": "Paris",
        "main_text_matched_substrings": [
          {
            "length": 5,
            "offset": 0
          }
        ],
        "secondary_text": "TX, USA"
      },
      "terms": [
        {
          "offset": 0,
          "value": "Paris"
        },
        {
          "offset": 7,
          "value": "TX"
        },
        {
          "offset": 11,
          "value": "USA"
        }
      ],
      "types": [
        "locality",
        "political",
        "geocode"
      ]
    },
    {
      "description": "Paris, TN, USA",
      "matched_substrings": [
        {
          "length": 5,
          "offset": 0
        }
      ],
      "place_id": "ChIJ4zHP-Sije4gRBDEsVxunOWg",
      "reference": "ChIJ4zHP-Sije4gRBDEsVxunOWg",
      "structured_formatting": {
        "main_text": "Paris",
        "main_text_matched_substrings": [
          {
            "length": 5,
            "offset": 0
          }
        ],
        "secondary_text": "TN, USA"
      },
      "terms": [
        {
          "offset": 0,
          "value": "Paris"
        },
        {
          "offset": 7,
          "value": "TN"
        },
        {
          "offset": 11,
          "value": "USA"
        }
      ],
      "types": [
        "locality",
        "political",
        "geocode"
      ]
    },
    {
      "description": "Paris, Brant, ON, Canada",
      "matched_substrings": [
        {
          "length": 5,
          "offset": 0
        }
      ],
      "place_id": "ChIJsamfQbVtLIgR-X18G75Hyi0",
      "reference": "ChIJsamfQbVtLIgR-X18G75Hyi0",
      "structured_formatting": {
        "main_text": "Paris",
        "main_text_matched_substrings": [
          {
            "length": 5,
            "offset": 0
          }
        ],
        "secondary_text": "Brant, ON, Canada"
      },
      "terms": [
        {
          "offset": 0,
          "value": "Paris"
        },
        {
          "offset": 7,
          "value": "Brant"
        },
        {
          "offset": 14,
          "value": "ON"
        },
        {
          "offset": 18,
          "value": "Canada"
        }
      ],
      "types": [
        "neighborhood",
        "political",
        "geocode"
      ]
    },
    {
      "description": "Paris, KY, USA",
      "matched_substrings": [
        {
          "length": 5,
          "offset": 0
        }
      ],
      "place_id": "ChIJsU7_xMfKQ4gReI89RJn0-RQ",
      "reference": "ChIJsU7_xMfKQ4gReI89RJn0-RQ",
      "structured_formatting": {
        "main_text": "Paris",
        "main_text_matched_substrings": [
          {
            "length": 5,
            "offset": 0
          }
        ],
        "secondary_text": "KY, USA"
      },
      "terms": [
        {
          "offset": 0,
          "value": "Paris"
        },
        {
          "offset": 7,
          "value": "KY"
        },
        {
          "offset": 11,
          "value": "USA"
        }
      ],
      "types": [
        "locality",
        "political",
        "geocode"
      ]
    }
  ],
  "status": "OK"
};

const _kInvalidRequestResponse = {
  "predictions": [],
  "status": "INVALID_REQUEST"
};