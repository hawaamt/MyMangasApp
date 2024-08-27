//
//  Manga.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 6/6/24.
//

import Foundation

extension Manga {
    
    static var placeholder = Manga(
        id: 999,
        title: "Placeholder",
        volumes: 0,
        chapters: 0,
        url: "",
        background: "",
        score: 0,
        startDate: Date(),
        endDate: Date(),
        genres: [],
        authors: [],
        demographics: [],
        themes: [],
        status: .inProgress,
        sypnosis: "",
        mainPicture: "",
        titleJapanese: "",
        titleEnglish: ""
    )
    
    static var manga1 = Manga(
        id: 1,
        title: "Berserk",
        volumes: 10,
        chapters: 50,
        url: "https://myanimelist.net/manga/2/Berserk",
        background: "Berserk won the Award for Excellence at the sixth installment of Tezuka Osamu Cultural Prize in 2002. The series has over 50 million copies in print worldwide and has been published in English by Dark Horse since November 4, 2003. It is also published in Italy, Germany, Spain, France, Brazil, South Korea, Hong Kong, Taiwan, Thailand, Poland, México and Turkey. In May 2021, the author Kentaro Miura suddenly died at the age of 54. Chapter 364 of Berserk was published posthumously on September 10, 2021. Miura would often share details about the series' story with his childhood friend and fellow mangaka Kouji Mori. Berserk resumed on June 24, 2022, with Studio Gaga handling the art and Kouji Mori's supervision.",
        score: 9.24,
        startDate: Date(),
        endDate: Date(),
        genres: [Genre(id: "1", genre: "Action"), Genre(id: "2", genre: "Adventure")],
        authors: [Author(id: "1", firstName: "Kentarou", role: .story, lastName: "Miura"),
                  Author(id: "2", firstName: "Eiichiro", role: .art, lastName: "Oda")],
        demographics: [Demographic(id: "1", demographic: "Shonen")],
        themes: [Theme(id: "1", theme: "Fantasy")],
        status: .finished,
        sypnosis: "Guts, a former mercenary now known as the Black Swordsman, is out for revenge. After a tumultuous childhood, he finally finds someone he respects and believes he can trust, only to have everything fall apart when this person takes away everything important to Guts for the purpose of fulfilling his own desires. Now marked for death, Guts becomes condemned to a fate in which he is relentlessly pursued by demonic beings.\n\nSetting out on a dreadful quest riddled with misfortune, Guts, armed with a massive sword and monstrous strength, will let nothing stop him, not even death itself, until he is finally able to take the head of the one who stripped him—and his loved one—of their humanity.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 14: Berserk: The Prototype",
        mainPicture: "https://cdn.myanimelist.net/images/manga/2/188925l.jpg",
        titleJapanese: "バガボンド",
        titleEnglish: "Vagabond"
    )
    
    static var manga2 = Manga(
        id: 2,
        title: "One Piece",
        volumes: nil,
        chapters: nil,
        url: "https://myanimelist.net/manga/13/One_Piece",
        background: "One Piece is the highest-selling manga series in history, with over 490 million copies in print worldwide. It has been serialized in Shueisha's Weekly Shōnen Jump magazine since July 22, 1997, and has been collected into 104 tankōbon volumes as of January 2023. The manga has been adapted into an original video animation (OVA) produced by Production I.G in 1999, and an anime series produced by Toei Animation, which began broadcasting in Japan in 1999 and is still ongoing.",
        score: 9.16,
        startDate: Date(),
        endDate: nil,
        genres: [Genre(id: "1", genre: "Action"), Genre(id: "2", genre: "Adventure"), Genre(id: "3", genre: "Comedy")],
        authors: [Author(id: "2", firstName: "Eiichiro", role: .art, lastName: "Oda")],
        demographics: [Demographic(id: "1", demographic: "Shonen")],
        themes: [Theme(id: "1", theme: "Pirates"), Theme(id: "2", theme: "Sea")],
        status: .inProgress,
        sypnosis: "Monkey D. Luffy refuses to let anyone or anything stand in the way of his quest to become the king of all pirates. With a course charted for the treacherous waters of the Grand Line and beyond, this is one captain who'll never give up until he's claimed the greatest treasure on Earth: the Legendary One Piece!",
        mainPicture: "https://cdn.myelist.net/images/manga/2/253146l.jpg",
        titleJapanese: "ワンピース",
        titleEnglish: nil
    )
    
    static var manga3 = Manga(
        id: 3,
        title: "JoJo no Kimyou",
        volumes: 27,
        chapters: 116,
        url: "https://myanimelist.net/manga/25/Fullmetal_Alchemist",
        background: "Fullmetal Alchemist won the Shogakukan Manga Award for shōnen in 2004. The manga was adapted into two anime television series, both of which were highly acclaimed. The first anime, Fullmetal Alchemist, aired from 2003 to 2004 and was produced by Bones. The second anime, Fullmetal Alchemist: Brotherhood, aired from 2009 to 2010 and was also produced by Bones. Both anime series were very popular and received critical acclaim.",
        score: 9.13,
        startDate: Date(),
        endDate: Date(),
        genres: [Genre(id: "1", genre: "Action"), Genre(id: "4", genre: "Military"), Genre(id: "5", genre: "Adventure")],
        authors: [Author(id: "3", firstName: "Hiromu", role: .storyArt, lastName: "Arakawa"),
                  Author(id: "2", firstName: "Eiichiro", role: .art, lastName: "Oda"),
                  Author(id: "1", firstName: "Kentarou", role: .story, lastName: "Miura")],
        demographics: [Demographic(id: "1", demographic: "Shonen")],
        themes: [Theme(id: "3", theme: "Alchemy"), Theme(id: "4", theme: "Military")],
        status: .finished,
        sypnosis: "Edward Elric, a young, brilliant alchemist, has lost much in his twelve-year life: when he and his brother Alphonse try to resurrect their dead mother through the forbidden act of human transmutation, Edward loses his left leg, Alphonse his physical body. Devastated, Edward sacrifices his right arm to bind Alphonse's soul to a suit of armor.\n\nNow a famous alchemist known as the Fullmetal Alchemist, Edward embarks on a journey with his younger brother to obtain the Philosopher's Stone. The stone is a powerful object that could restore their bodies to normal, but it is also a valuable tool in the hands of the military. Along the way, they discover that the military has its own sinister agenda, and that the Philosopher's Stone is tied to a much darker history than they could have imagined.",
        mainPicture: "https://cdn.myanimelist.net/images/manga/3/179882l.jpg",
        titleJapanese: "鋼の錬金術師",
        titleEnglish: "Hagane no Renkinjutsushi"
    )
    
    static var mockList: [Manga] = [.manga1, .manga2, .manga3]
}
