package com.green.mapper;

import com.green.vo.*;

import java.util.List;

public interface AdminMapper {
    /* 상품 등록 */
    public void ProductEnroll(ProductVO product);

    /* 카테고리 리스트 */
    public List<CategoryVO> cateList();

    /* 상품 리스트 */
    public List<ProductVO> goodsGetList(Criteria cri);

    /* 상품 총 개수 */
    public int goodsGetTotal(Criteria cri);

    /* 상품 조회 페이지 */
    public ProductVO goodsGetDetail(int id);

    /* 상품 수정 */
    public int goodsModify(ProductVO vo);

    /* 상품 정보 삭제 */
    public int goodsDelete(int id);

    /* 이미지 등록 */
    public void imageEnroll(AttachImageVO vo);
    //
    /* 지정 상품 이미지 전체 삭제 */
    public void deleteImageAll(int id);

    //    /* 어제자 날짜 이미지 리스트 */
//    public List<AttachImageVO> checkFileList();
//
//    /* 지정 상품 이미지 정보 얻기 */
    public List<AttachImageVO> getAttachInfo(int id);

    /* 주문 상품 리스트 */
    public List<OrderDTO> getOrderList(Criteria cri);

    /* 주문 총 갯수 */
    public int getOrderTotal(Criteria cri);
}
