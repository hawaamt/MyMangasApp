//
//  MangaDTO+Manga.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 5/6/24.
//

import Foundation

extension MangaListDTO {
    
    var manga: MangaPaginated {
        MangaPaginated(pagination: metadata.pagination,
                       items: items?.map { $0.manga })
    }
}

extension MangaMetaDTO {
    
    var pagination: MangaPagination {
        MangaPagination(page: page,
                        per: per)
    }
}

extension MangaItemDTO {
    
    var manga: Manga {
        Manga(id: id,
              title: title,
              volumes: volumes,
              chapters: chapters,
              url: url,
              background: background,
              score: score,
              startDate: startDate,
              endDate: endDate,
              genres: genres.map { $0.genreData },
              authors: authors.map { $0.author },
              demographics: demographics.map { $0.demographicData },
              themes: themes.map { $0.themeData },
              status: status,
              sypnosis: sypnosis,
              mainPicture: mainPicture,
              titleJapanese: titleJapanese,
              titleEnglish: titleEnglish)
    }
}

extension AuthorDTO {
    
    var author: Author {
        Author(id: id,
               firstName: firstName,
               role: role,
               lastName: lastName)
    }
}

extension DemographicDTO {
    
    var demographicData: Demographic {
        Demographic(id: id,
                    demographic: demographic)
    }
}

extension GenreDTO {
    
    var genreData: Genre {
        Genre(id: id,
              genre: genre)
    }
}

extension ThemeDTO {
    
    var themeData: Theme {
        Theme(id: id,
              theme: theme)
    }
}
