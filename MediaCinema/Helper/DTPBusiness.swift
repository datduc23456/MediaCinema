//
//  DTPBusiness.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation

class DTPBusiness {
    static let shared = DTPBusiness()
    var listGenres: [Genre] = []
    var tvShowSelectedId: Int = 0
    var genreSelectedId: Int = 0
    var realmUtils: RealmUtils = AppDelegate.shared.realmUtils!
    var numberTapSeemore: Int = 0
    func mapToGenreName(_ listGenreIds: [Int]) -> String {
        var listGenresFilter: [Genre] = []
        
        for id in listGenreIds {
            if let genre = listGenres.first(where: {$0.id == id}) {
                listGenresFilter.append(genre)
            }
        }
        
        return listGenresFilter.map { $0.name }.reduce("") { (result, next) -> String in
            if result.isEmpty {
                return next
            }
            return "\(result), \(next)"
        }
    }
    
    func roundRating(_ rating: Double) -> String {
        if rating < 1000 {
            return "\(Int(rating))"
        } else {
            let rounded = rating.rounded(toPlaces: 3)
            return "\(Int(rounded))k"
        }
    }
    
    func roundVote(maxDigit: Int = 2, _ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = maxDigit
        return numberFormatter.string(from: value as NSNumber).isNil(value: "0")
    }
    
    func getMovieInfoString(_ movie: MovieDetail) -> String {
        let hoursAndMinutes = CommonUtil.minutesToHoursAndMinutes(movie.runtime)
        let first2 = Array(movie.genres.prefix(2))
        return "\(hoursAndMinutes.hours)h\(hoursAndMinutes.leftMinutes)min | \(mapToGenreName(first2.map({ $0.id }))) | \(movie.releaseDate.toDateFormat(toFormat: "dd MMMM yyyy"))"
    }
    
    func fetchMyReviewWithId(_ id: String, completion: ((ReviewsResultObject?) -> Void)) {
        let predicate = NSPredicate(format: "_id == %@", id)
        let query = realmUtils.dataQueryByPredicate(type: ReviewsResultObject.self, predicate: predicate)
        if !query.isEmpty {
            completion(query[0])
        } else {
            completion(nil)
        }
    }
    
    func fetchMyReviewWithMovieId(_ movieId: Int, completion: (([ReviewsResultObject]) -> Void)) {
        let predicate = NSPredicate(format: "movieId == %@", NSNumber(value: movieId))
        var query = realmUtils.dataQueryByPredicate(type: ReviewsResultObject.self, predicate: predicate)
        query = query.sorted(byKeyPath: "createdAt", ascending: false)
        completion(Array(query))
    }
    
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject?) -> Void)) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
        if !query.isEmpty {
            completion(query[0])
        } else {
            completion(nil)
        }
    }
    
    func fetchWatchedListObjectWithId(_ id: Int, completion: ((WatchedListObject?) -> Void)) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: WatchedListObject.self, predicate: predicate)
        if !query.isEmpty {
            completion(query[0])
        } else {
            completion(nil)
        }
    }
    
    func fetchWatchedListObjects(completion: (([WatchedListObject]) -> Void)) {
        let query = Array(realmUtils.dataQuery(type: WatchedListObject.self))
        completion(query)
    }
    
    func deleteWatchedListObject(_ movie: WatchedListObject, completion: ((WatchedListObject?) -> Void)) {
        self.fetchWatchedListObjectWithId(movie._id, completion: { object in
            if let object {
                self.realmUtils.deleteObject(object: object)
            }
            completion(object)
        })
    }
    
    func fetchMovieDetailObjectWatchedListWithId(_ id: Int, completion: ((MovieDetailObject?) -> Void)) {
        fetchRealmMovieDetailObjectWithId(id, completion: { movie in
            if let movie, movie.isWatchedList {
                completion(movie)
            } else {
                completion(nil)
            }
        })
    }
    
    func deleteMovieDetailObject(_ movie: MovieDetail, completion: ((MovieDetailObject?) -> Void)) {
        self.fetchRealmMovieDetailObjectWithId(movie.id, completion: { object in
            if let object {
                self.realmUtils.deleteObject(object: object)
            }
            completion(object)
        })
    }
    
    func deleteReviewsResultObject(_ review: ReviewsResultObject, completion: ((ReviewsResultObject?) -> Void)) {
        self.fetchMyReviewWithId(review._id, completion: { object in
            if let object {
                self.realmUtils.deleteObject(object: object)
            }
            completion(object)
        })
    }
    
    func insertMovieDetailObject(_ movie: MovieDetail) {
        self.realmUtils.insertOrUpdate(movie.toMovieObject())
    }
    
    func insertReviewsResultObject(_ review: ReviewsResultObject) {
        self.realmUtils.insertOrUpdate(review)
    }
    
    func insertWatchedListObject(_ review: WatchedListObject) {
        self.realmUtils.insertOrUpdate(review)
    }
}
