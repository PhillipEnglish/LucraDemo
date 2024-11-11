//
//  AlbumVMTests.swift
//  LucraDemoTests
//
//  Created by Phillip English on 11/11/24.
//

import XCTest
@testable import LucraDemo

final class AlbumVMTests: XCTestCase {
    func testFetchAlbumsSuccess() async {
            let viewModel = MockAlbumViewModel()
            await viewModel.fetchAlbums(for: "Test")
            
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.albums.count, 1)
            XCTAssertEqual(viewModel.albums.first?.title, "Test Album")
        }
        
        func testFetchAlbumsFailure() async {
            let viewModel = MockAlbumViewModel(shouldFail: true)
            await viewModel.fetchAlbums(for: "Test")
            
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.albums.count, 0)
            XCTAssertEqual(viewModel.errorMessage, "Failed to load albums.")
        }
        
        func testResetAlbums() {
            let viewModel = MockAlbumViewModel()
            viewModel.albums = [Album(id: "1", title: "Temp Album", images: [])]
            viewModel.resetAlbums()
            
            XCTAssertTrue(viewModel.albums.isEmpty)
        }
}
