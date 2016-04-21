//
//  ViewController.m
//  StreamTest
//
//  Created by AKSHAY SUNDERWANI on 03/04/16.
//  Copyright © 2016 AKSHAY SUNDERWANI. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVPlayerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewForMoviePlayer;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)nextChannel:(id)sender;
- (IBAction)status:(id)sender;
- (IBAction)prevChannel:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblChannelName;

@end

@implementation ViewController{
    
    AVPlayer *player;
    AVPlayerViewController *playerController;
    
    NSMutableArray *urlArray;
    NSMutableArray *channelArray;
    NSInteger counter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    urlArray = [[NSMutableArray alloc] init];
    channelArray = [[NSMutableArray alloc] init];
    
    [self fillChannelArray];
    [self fillURLArray];

    counter = 0;
    
}

-(void)fillURLArray{
    
    [urlArray addObject:[NSURL URLWithString:@"http://zeefamily2-i.akamaihd.net/hls/live/231616/andtvhdts/chunklist.m3u8"]];
    [urlArray addObject:[NSURL URLWithString:@"http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/master.m3u8"]];
    [urlArray addObject:[NSURL URLWithString:@"http://d2ckk42trw29cy.cloudfront.net/9xmedia/ngrp:9xmusic_all/chunklist_b500000.m3u8"]];
    [urlArray addObject:[NSURL URLWithString:@"http://stream.zliving.online/zeetvhdus_domain_tracking/index.m3u8"]];
    [urlArray addObject:[NSURL URLWithString:@"http://43.252.111.46:8080/aaa/mtv/index.m3u8"]];

    
}

-(void)fillChannelArray{
    
    [channelArray addObject:@"&TV"];
    [channelArray addObject:@"INDIA TV"];
    [channelArray addObject:@"9XM"];
    [channelArray addObject:@"ZEE TV"];
    [channelArray addObject:@"MTV"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    playerController = [[AVPlayerViewController alloc] init];
    
    playerController.view.frame = CGRectMake(0, 0, self.viewForMoviePlayer.frame.size.width, self.viewForMoviePlayer.frame.size.height);
    
    player = [AVPlayer playerWithURL:[urlArray objectAtIndex:0]];
    
    self.lblChannelName.text = [channelArray objectAtIndex:0];
    
    playerController.player = player;
    
    [self.viewForMoviePlayer addSubview:playerController.view];

}

- (IBAction)play:(id)sender {
    
    [player play];
    
}

- (IBAction)stop:(id)sender {
    
    [player pause];
    
}

- (IBAction)nextChannel:(id)sender {
    
    counter = counter + 1;
    
    if (counter > (urlArray.count - 1)) {
        counter = 0;
    }
    
    player = [AVPlayer playerWithURL:[urlArray objectAtIndex:counter]];
    
    self.lblChannelName.text = [channelArray objectAtIndex:counter];
    
    playerController.player = player;

    [player play];
}

- (IBAction)status:(id)sender {
    
    
}

- (IBAction)prevChannel:(id)sender {
    
    counter = counter - 1;
    
    if (counter < 0) {
        counter = [urlArray count]-1;
    }

    player = [AVPlayer playerWithURL:[urlArray objectAtIndex:counter]];
    
    self.lblChannelName.text = [channelArray objectAtIndex:counter];
    
    playerController.player = player;

    [player play];
}

@end
