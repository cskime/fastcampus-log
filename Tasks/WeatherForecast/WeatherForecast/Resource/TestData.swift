//
//  TestData.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

struct TestData {
  static let current =
    """
    {
        "weather": {
            "hourly": [
                {
                    "grid": {
                        "latitude": "36.10499",
                        "longitude": "127.13747",
                        "city": "충남",
                        "county": "논산시",
                        "village": "가야곡면"
                    },
                    "sky": {
                        "code": "SKY_O01",
                        "name": "맑음"
                    },
                    "temperature": {
                        "tc": "11.10",
                        "tmax": "11.00",
                        "tmin": "1.00"
                    },
                    "humidity": "50.00",
                    "lightning": "0",
                    "wind": {
                        "wdir": "325.00",
                        "wspd": "1.90"
                    },
                    "precipitation": {
                        "sinceOntime": "0.00",
                        "type": "0"
                    },
                    "sunRiseTime": "2020-02-27 07:05:00",
                    "sunSetTime": "2020-02-27 18:24:00",
                    "timeRelease": "2020-02-27 13:00:00"
                }
            ]
        },
        "common": {
            "alertYn": "N",
            "stormYn": "N"
        },
        "result": {
            "code": 9200,
            "requestUrl": "/weather/current/hourly?appKey=l7xx1f8d7578e5b64b78a97e0a6011ec5059&version=2&lat=36.1234&lon=127.1234",
            "message": "성공"
        }
    }
    """.data(using: .utf8)
  
  static let shortRange =
  """
  {
      "weather": {
          "forecast3days": [
              {
                  "grid": {
                      "latitude": "36.10499",
                      "longitude": "127.13747",
                      "city": "충남",
                      "county": "논산시",
                      "village": "가야곡면"
                  },
                  "fcst3hour": {
                      "wind": {
                          "wdir4hour": "124.00",
                          "wspd4hour": "1.10",
                          "wdir7hour": "135.00",
                          "wspd7hour": "1.00",
                          "wdir10hour": "120.00",
                          "wspd10hour": "0.80",
                          "wdir13hour": "122.00",
                          "wspd13hour": "0.90",
                          "wdir16hour": "140.00",
                          "wspd16hour": "1.60",
                          "wdir19hour": "138.00",
                          "wspd19hour": "1.50",
                          "wdir22hour": "122.00",
                          "wspd22hour": "1.30",
                          "wdir25hour": "103.00",
                          "wspd25hour": "0.90",
                          "wdir28hour": "96.00",
                          "wspd28hour": "0.90",
                          "wdir31hour": "84.00",
                          "wspd31hour": "1.00",
                          "wdir34hour": "63.00",
                          "wspd34hour": "0.90",
                          "wdir37hour": "45.00",
                          "wspd37hour": "1.00",
                          "wdir40hour": "20.00",
                          "wspd40hour": "2.00",
                          "wdir43hour": "4.00",
                          "wspd43hour": "2.70",
                          "wdir46hour": "13.00",
                          "wspd46hour": "2.20",
                          "wdir49hour": "13.00",
                          "wspd49hour": "0.90",
                          "wdir52hour": "30.00",
                          "wspd52hour": "0.80",
                          "wdir55hour": "",
                          "wspd55hour": "",
                          "wdir58hour": "",
                          "wspd58hour": "",
                          "wdir61hour": "",
                          "wspd61hour": "",
                          "wdir64hour": "",
                          "wspd64hour": "",
                          "wdir67hour": "",
                          "wspd67hour": ""
                      },
                      "precipitation": {
                          "type4hour": "0",
                          "prob4hour": "20.00",
                          "type7hour": "0",
                          "prob7hour": "20.00",
                          "type10hour": "0",
                          "prob10hour": "20.00",
                          "type13hour": "0",
                          "prob13hour": "30.00",
                          "type16hour": "1",
                          "prob16hour": "60.00",
                          "type19hour": "1",
                          "prob19hour": "60.00",
                          "type22hour": "1",
                          "prob22hour": "60.00",
                          "type25hour": "0",
                          "prob25hour": "30.00",
                          "type28hour": "0",
                          "prob28hour": "30.00",
                          "type31hour": "0",
                          "prob31hour": "30.00",
                          "type34hour": "0",
                          "prob34hour": "20.00",
                          "type37hour": "0",
                          "prob37hour": "20.00",
                          "type40hour": "0",
                          "prob40hour": "20.00",
                          "type43hour": "0",
                          "prob43hour": "0.00",
                          "type46hour": "0",
                          "prob46hour": "0.00",
                          "type49hour": "0",
                          "prob49hour": "0.00",
                          "type52hour": "0",
                          "prob52hour": "0.00",
                          "type55hour": "",
                          "prob55hour": "",
                          "type58hour": "",
                          "prob58hour": "",
                          "type61hour": "",
                          "prob61hour": "",
                          "type64hour": "",
                          "prob64hour": "",
                          "type67hour": "",
                          "prob67hour": ""
                      },
                      "sky": {
                          "code4hour": "SKY_S03",
                          "name4hour": "구름많음",
                          "code7hour": "SKY_S03",
                          "name7hour": "구름많음",
                          "code10hour": "SKY_S03",
                          "name10hour": "구름많음",
                          "code13hour": "SKY_S07",
                          "name13hour": "흐림",
                          "code16hour": "SKY_S08",
                          "name16hour": "흐리고 비",
                          "code19hour": "SKY_S08",
                          "name19hour": "흐리고 비",
                          "code22hour": "SKY_S08",
                          "name22hour": "흐리고 비",
                          "code25hour": "SKY_S07",
                          "name25hour": "흐림",
                          "code28hour": "SKY_S07",
                          "name28hour": "흐림",
                          "code31hour": "SKY_S07",
                          "name31hour": "흐림",
                          "code34hour": "SKY_S03",
                          "name34hour": "구름많음",
                          "code37hour": "SKY_S03",
                          "name37hour": "구름많음",
                          "code40hour": "SKY_S03",
                          "name40hour": "구름많음",
                          "code43hour": "SKY_S01",
                          "name43hour": "맑음",
                          "code46hour": "SKY_S01",
                          "name46hour": "맑음",
                          "code49hour": "SKY_S01",
                          "name49hour": "맑음",
                          "code52hour": "SKY_S01",
                          "name52hour": "맑음",
                          "code55hour": "",
                          "name55hour": "",
                          "code58hour": "",
                          "name58hour": "",
                          "code61hour": "",
                          "name61hour": "",
                          "code64hour": "",
                          "name64hour": "",
                          "code67hour": "",
                          "name67hour": ""
                      },
                      "temperature": {
                          "temp4hour": "3.00",
                          "temp7hour": "4.00",
                          "temp10hour": "2.00",
                          "temp13hour": "4.00",
                          "temp16hour": "6.00",
                          "temp19hour": "6.00",
                          "temp22hour": "6.00",
                          "temp25hour": "6.00",
                          "temp28hour": "3.00",
                          "temp31hour": "1.00",
                          "temp34hour": "0.00",
                          "temp37hour": "5.00",
                          "temp40hour": "11.00",
                          "temp43hour": "14.00",
                          "temp46hour": "11.00",
                          "temp49hour": "6.00",
                          "temp52hour": "4.00",
                          "temp55hour": "",
                          "temp58hour": "",
                          "temp61hour": "",
                          "temp64hour": "",
                          "temp67hour": ""
                      },
                      "humidity": {
                          "rh4hour": "85.00",
                          "rh64hour": "",
                          "rh67hour": "",
                          "rh7hour": "90.00",
                          "rh10hour": "90.00",
                          "rh13hour": "85.00",
                          "rh16hour": "80.00",
                          "rh19hour": "85.00",
                          "rh22hour": "80.00",
                          "rh25hour": "85.00",
                          "rh28hour": "90.00",
                          "rh31hour": "95.00",
                          "rh34hour": "95.00",
                          "rh37hour": "90.00",
                          "rh40hour": "70.00",
                          "rh43hour": "60.00",
                          "rh46hour": "55.00",
                          "rh49hour": "80.00",
                          "rh52hour": "85.00",
                          "rh55hour": "",
                          "rh58hour": "",
                          "rh61hour": ""
                      }
                  },
                  "timeRelease": "2020-02-27 20:00:00",
                  "fcst6hour": {
                      "rain6hour": "없음",
                      "rain12hour": "없음",
                      "rain18hour": "1~4mm",
                      "rain24hour": "1~4mm",
                      "rain30hour": "없음",
                      "rain36hour": "없음",
                      "rain42hour": "없음",
                      "rain48hour": "없음",
                      "rain54hour": "없음",
                      "snow6hour": "없음",
                      "snow12hour": "없음",
                      "snow18hour": "없음",
                      "snow24hour": "없음",
                      "snow30hour": "없음",
                      "snow36hour": "없음",
                      "snow42hour": "없음",
                      "snow48hour": "없음",
                      "snow54hour": "없음",
                      "rain60hour": "",
                      "rain66hour": "",
                      "snow60hour": "",
                      "snow66hour": ""
                  },
                  "fcstdaily": {
                      "temperature": {
                          "tmax1day": "",
                          "tmax2day": "8.00",
                          "tmax3day": "14.00",
                          "tmin1day": "",
                          "tmin2day": "2.00",
                          "tmin3day": "0.00"
                      }
                  }
              }
          ]
      },
      "common": {
          "alertYn": "N",
          "stormYn": "N"
      },
      "result": {
          "code": 9200,
          "requestUrl": "/weather/forecast/3days?appKey=l7xx1f8d7578e5b64b78a97e0a6011ec5059&version=2&lat=36.1234&lon=127.1234",
          "message": "성공"
      }
  }
  """.data(using: .utf8)
}
