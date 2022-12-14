//
//  Posts.swift
//  Navigation
//
//  Created by Oleg Popov on 07.09.2022.
//

import Foundation
import UIKit

public struct PostModel {
    public var autor: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int

}

public var viewModel = [post1, post2, post3, post4, post5]

let post1  = PostModel(autor: "Svinki.ru", description: "Находясь в естественных условиях, дикие морские свинки предпочитают проявлять свою активность, как с восходом солнца, так и с наступлением сумерек. Не смотря на свои размеры, зверьки бегают достаточно быстро и считаются весьма проворными, всегда находящимися настороже. /nОбитает дикая морская свинка, как в лесных массивах, так и в гористой местности. Для обустройства своего гнезда они подыскивают тихие укромные места, при этом нор они не роют. Чтобы сформировать свое жилище они пользуются сухой травой, пухом и тонкими ветками деревьев и кустарников.", image: "pigs", likes: 157_032, views: 250_017)

let post2 = PostModel(autor: "4lapy.ru", description: "Морские свинки – очаровательные грызуны, которые прекрасно ладят с человеком. “Морскими” эти зверьки называются в русском, польском и немецком языках. Скорее всего, причина в том, что они прибыли к нам “из-за моря”. В других языках свинки называются гвинейскими.\n Средняя продолжительность жизни грызуна – 5-7 лет. Однако при надлежащем уходе некоторые особи способны перешагнуть десятилетний рубеж. Что же необходимо им для комфортной жизни?", image: "svinogyrec", likes: 3_543, views: 7_012)

let post3 = PostModel(autor: "4lapy.ru", description: "Дикие морские свинки — энергичные животные, свою активность они обычно проявляют в утреннее время дня или вечером после заката. Застать врасплох этих зверьков практически невозможно. Они непоседливые и шустрые. Живут морские свинки в горных местностях. Также их можно встретить в лесных зонах. \n В случае если животные не находят больших и глубоких нор, они обустраивают себе жилище в виде гнезда. Место выбирают тихое и уединённое. Укрепляют своё жилище грызуны, используя тонкие веточки растений и сухую траву.", image: "svinkiedyat", likes: 230_117, views: 716_011)

let post4 = PostModel(autor: "vplate.ru", description: "Морские свинки не переносят одиночества, поэтому они объединяются в колонии и живут на одном периметре. Количество самок в стае обычно в разы превосходит количество самцов. Домашние питомцы в основном живут в больших клетках. Им необходимо много пространства для выгула. Спят морские свинки несколько раз в день. В некоторых случаях зверёк может отдыхать с открытыми глазами. \n Морские свинки также умеют плавать. Для них не составит большого труда пересечь небольшой водоём. Также зверьки нормально переносят повышенную влажность, дожди им не страшны. Некоторые представители морских свинок обустраивают своё жилище близ водоёма. Их пищей могут быть водоросли и другие растения, произрастающие в воде.", image: "morkovka", likes: 13_876, views: 24_734)

let post5 = PostModel(autor: "Svinki.ru", description: "Кормление\n Животное должно хорошо питаться, необходимо чтобы рацион состоял из четырёх приёмов пищи. Одна порция составляет 2 столовые ложки. Сначала морская свинка может всё не съедать. Но это не значит, что объём порции нужно сокращать. Сытость этих животных является залогом отличного здоровья.\n Морские свинки питаются сеном, а летом — свежей травой. Во время беременности самки и кормления потомства подкорм осуществляется не чаще двух раз в день. Петрушка в этот период противопоказана. В воду, предназначенную для питомцев, рекомендуется добавлять витамин C, в случае, если корма не содержат в своём составе этот компонент.", image: "Foto00008", likes: 14_891, views: 57_123)
     

